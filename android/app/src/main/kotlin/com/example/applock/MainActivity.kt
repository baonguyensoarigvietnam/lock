package com.example.applock

import android.content.Intent
import android.net.Uri
import android.provider.Settings
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Must extend [FlutterFragmentActivity] because `local_auth` (biometric
 * prompt) requires a FragmentActivity.
 */
class MainActivity : FlutterFragmentActivity() {

    private var channel: MethodChannel? = null
    private var pendingLock: Map<String, String>? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        captureLockIntent(intent)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                try {
                    handleCall(call.method, call.arguments, result)
                } catch (e: Exception) {
                    result.error("native_error", e.message, null)
                }
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        if (captureLockIntent(intent)) {
            channel?.invokeMethod("onLockRequested", pendingLock)
        }
    }

    private fun captureLockIntent(intent: Intent?): Boolean {
        val pkg = intent?.getStringExtra(EXTRA_LOCK_PACKAGE) ?: return false
        val name = intent.getStringExtra(EXTRA_LOCK_APP_NAME) ?: pkg
        pendingLock = mapOf("packageName" to pkg, "appName" to name)
        intent.removeExtra(EXTRA_LOCK_PACKAGE)
        intent.removeExtra(EXTRA_LOCK_APP_NAME)
        return true
    }

    private fun handleCall(method: String, args: Any?, result: MethodChannel.Result) {
        val prefs = LockPrefs(this)
        when (method) {
            "hasUsageAccess" -> result.success(PermissionUtils.hasUsageAccess(this))
            "openUsageAccessSettings" -> {
                openSettings(Settings.ACTION_USAGE_ACCESS_SETTINGS, withPackage = false)
                result.success(true)
            }
            "canDrawOverlays" -> result.success(PermissionUtils.canDrawOverlays(this))
            "openOverlaySettings" -> {
                openSettings(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, withPackage = true)
                result.success(true)
            }
            "isIgnoringBatteryOptimizations" ->
                result.success(PermissionUtils.isIgnoringBatteryOptimizations(this))
            "openBatteryOptimizationSettings" -> {
                // Opens the system list; avoids the restricted
                // REQUEST_IGNORE_BATTERY_OPTIMIZATIONS permission.
                openSettings(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS, withPackage = false)
                result.success(true)
            }
            "setLockedPackages" -> {
                @Suppress("UNCHECKED_CAST")
                val list = (args as? List<String>) ?: emptyList()
                prefs.lockedPackages = list.filter { it != packageName }.toSet()
                result.success(true)
            }
            "setRelockPolicy" -> {
                val map = args as? Map<*, *>
                prefs.relockDelayMs = (map?.get("delayMs") as? Number)?.toLong() ?: 0L
                prefs.relockOnScreenOff = map?.get("onScreenOff") as? Boolean ?: false
                result.success(true)
            }
            "startService" -> {
                if (!PermissionUtils.hasUsageAccess(this)) {
                    result.success(false)
                    return
                }
                prefs.serviceEnabled = true
                LockMonitorService.start(this)
                result.success(true)
            }
            "stopService" -> {
                prefs.serviceEnabled = false
                LockMonitorService.stop(this)
                result.success(true)
            }
            "isServiceRunning" -> result.success(LockMonitorService.isRunning)
            "markUnlocked" -> {
                val pkg = args as? String
                if (pkg != null) LockMonitorService.instance?.markUnlocked(pkg)
                result.success(true)
            }
            "consumePendingLock" -> {
                result.success(pendingLock)
                pendingLock = null
            }
            "clearPendingLock" -> {
                pendingLock = null
                result.success(true)
            }
            "moveToBack" -> result.success(moveTaskToBack(true))
            "goHome" -> {
                val home = Intent(Intent.ACTION_MAIN).apply {
                    addCategory(Intent.CATEGORY_HOME)
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK
                }
                startActivity(home)
                result.success(true)
            }
            "getLaunchableApps" -> {
                val appContext = applicationContext
                Thread {
                    val apps = try {
                        LaunchableApps.list(appContext)
                    } catch (_: Exception) {
                        emptyList()
                    }
                    runOnUiThread { result.success(apps) }
                }.start()
            }
            else -> result.notImplemented()
        }
    }

    private fun openSettings(action: String, withPackage: Boolean) {
        val intent = Intent(action).apply {
            if (withPackage) data = Uri.parse("package:$packageName")
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        try {
            startActivity(intent)
        } catch (_: Exception) {
            val fallback = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                data = Uri.parse("package:$packageName")
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            startActivity(fallback)
        }
    }

    companion object {
        const val CHANNEL = "com.example.applock/lock"
        const val EXTRA_LOCK_PACKAGE = "lock_package"
        const val EXTRA_LOCK_APP_NAME = "lock_app_name"
    }
}
