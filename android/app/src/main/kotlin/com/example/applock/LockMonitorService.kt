package com.example.applock

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager

/**
 * Foreground service that watches which app is in the foreground (via
 * UsageStatsManager) and brings up the Flutter lock screen when a protected
 * app is opened.
 */
class LockMonitorService : Service() {

    private data class Session(var leftAt: Long?)

    private val handler = Handler(Looper.getMainLooper())
    private lateinit var prefs: LockPrefs
    private var usageStatsManager: UsageStatsManager? = null

    private var lastForeground: String? = null
    private var lastEventTime: Long = 0L
    private val sessions = mutableMapOf<String, Session>()
    private var polling = false

    private val pollRunnable = object : Runnable {
        override fun run() {
            try {
                checkForeground()
            } catch (_: Exception) {
                // Never let a transient system error kill the service.
            }
            if (polling) handler.postDelayed(this, POLL_INTERVAL_MS)
        }
    }

    private val screenReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            when (intent?.action) {
                Intent.ACTION_SCREEN_OFF -> {
                    // Every protected app relocks once the screen goes off.
                    sessions.clear()
                    lastForeground = null
                    stopPolling()
                }
                Intent.ACTION_SCREEN_ON, Intent.ACTION_USER_PRESENT -> startPolling()
            }
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        instance = this
        prefs = LockPrefs(this)
        usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as? UsageStatsManager
        startInForeground()

        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_SCREEN_OFF)
            addAction(Intent.ACTION_SCREEN_ON)
            addAction(Intent.ACTION_USER_PRESENT)
        }
        registerReceiver(screenReceiver, filter)

        val power = getSystemService(Context.POWER_SERVICE) as PowerManager
        if (power.isInteractive) startPolling()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startInForeground()
        return START_STICKY
    }

    override fun onDestroy() {
        stopPolling()
        try {
            unregisterReceiver(screenReceiver)
        } catch (_: Exception) {
        }
        if (instance === this) instance = null
        super.onDestroy()
    }

    /** Called by the Flutter layer after the user successfully unlocked [packageName]. */
    fun markUnlocked(packageName: String) {
        sessions[packageName] = Session(leftAt = null)
    }

    private fun startPolling() {
        if (polling) return
        polling = true
        lastEventTime = System.currentTimeMillis() - INITIAL_LOOKBACK_MS
        handler.post(pollRunnable)
    }

    private fun stopPolling() {
        polling = false
        handler.removeCallbacks(pollRunnable)
    }

    private fun checkForeground() {
        val usm = usageStatsManager ?: return
        val now = System.currentTimeMillis()
        val events = usm.queryEvents(lastEventTime, now)
        val event = UsageEvents.Event()
        var latest: String? = null
        var latestTime = lastEventTime
        while (events.hasNextEvent()) {
            events.getNextEvent(event)
            @Suppress("DEPRECATION")
            val isResume = event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND
            if (isResume && event.timeStamp >= latestTime) {
                latest = event.packageName
                latestTime = event.timeStamp
            }
        }
        lastEventTime = maxOf(lastEventTime, latestTime)
        val current = latest ?: return
        if (current == lastForeground) return
        onForegroundChanged(lastForeground, current, now)
        lastForeground = current
    }

    private fun onForegroundChanged(previous: String?, current: String, now: Long) {
        if (previous != null && previous != packageName) {
            sessions[previous]?.let { if (it.leftAt == null) it.leftAt = now }
        }
        if (current == packageName) return
        if (!prefs.lockedPackages.contains(current)) return

        val session = sessions[current]
        val allowed = session != null && (
            session.leftAt == null ||
                prefs.relockOnScreenOff ||
                now - session.leftAt!! <= prefs.relockDelayMs
            )
        if (allowed) {
            session!!.leftAt = null
            return
        }
        sessions.remove(current)
        showLockScreen(current)
    }

    private fun showLockScreen(targetPackage: String) {
        val label = try {
            val info = packageManager.getApplicationInfo(targetPackage, 0)
            packageManager.getApplicationLabel(info).toString()
        } catch (_: PackageManager.NameNotFoundException) {
            targetPackage
        }
        val intent = Intent(this, MainActivity::class.java).apply {
            addFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP or
                    Intent.FLAG_ACTIVITY_NO_ANIMATION,
            )
            putExtra(MainActivity.EXTRA_LOCK_PACKAGE, targetPackage)
            putExtra(MainActivity.EXTRA_LOCK_APP_NAME, label)
        }
        startActivity(intent)
    }

    private fun startInForeground() {
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                getString(R.string.lock_service_channel_name),
                NotificationManager.IMPORTANCE_LOW,
            ).apply {
                description = getString(R.string.lock_service_channel_description)
                setShowBadge(false)
            }
            manager.createNotificationChannel(channel)
        }

        val openIntent = PendingIntent.getActivity(
            this,
            0,
            Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )

        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, CHANNEL_ID)
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(this)
        }
        val notification = builder
            .setSmallIcon(R.drawable.ic_stat_lock)
            .setContentTitle(getString(R.string.lock_service_notification_title))
            .setContentText(getString(R.string.lock_service_notification_text))
            .setContentIntent(openIntent)
            .setOngoing(true)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE,
            )
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }

    companion object {
        private const val CHANNEL_ID = "applock_protection"
        private const val NOTIFICATION_ID = 4201
        private const val POLL_INTERVAL_MS = 300L
        private const val INITIAL_LOOKBACK_MS = 10_000L

        @Volatile
        var instance: LockMonitorService? = null
            private set

        val isRunning: Boolean get() = instance != null

        fun start(context: Context) {
            val intent = Intent(context, LockMonitorService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun stop(context: Context) {
            context.stopService(Intent(context, LockMonitorService::class.java))
        }
    }
}
