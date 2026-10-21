package com.example.applock

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

/** Restarts protection after reboot or app update when the user had it enabled. */
class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action ?: return
        if (action != Intent.ACTION_BOOT_COMPLETED &&
            action != Intent.ACTION_MY_PACKAGE_REPLACED
        ) {
            return
        }
        val prefs = LockPrefs(context)
        if (!prefs.serviceEnabled || prefs.lockedPackages.isEmpty()) return
        if (!PermissionUtils.hasUsageAccess(context)) return
        try {
            LockMonitorService.start(context)
        } catch (_: Exception) {
            // Background start restrictions may apply on some OEMs.
        }
    }
}
