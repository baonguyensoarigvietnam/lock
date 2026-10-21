package com.example.applock

import android.content.Context
import android.content.SharedPreferences

/**
 * Native-side storage for the lock engine. The Flutter layer pushes its
 * configuration here through the method channel so the background service
 * can work even when the Flutter engine is not running (e.g. after reboot).
 */
class LockPrefs(context: Context) {
    private val prefs: SharedPreferences =
        context.applicationContext.getSharedPreferences(NAME, Context.MODE_PRIVATE)

    var lockedPackages: Set<String>
        get() = prefs.getStringSet(KEY_LOCKED, emptySet())?.toSet() ?: emptySet()
        set(value) = prefs.edit().putStringSet(KEY_LOCKED, value).apply()

    /** Grace period (ms) after leaving an unlocked app before it relocks. */
    var relockDelayMs: Long
        get() = prefs.getLong(KEY_DELAY, 0L)
        set(value) = prefs.edit().putLong(KEY_DELAY, value).apply()

    /** When true, unlocked apps stay unlocked until the screen turns off. */
    var relockOnScreenOff: Boolean
        get() = prefs.getBoolean(KEY_SCREEN_OFF, false)
        set(value) = prefs.edit().putBoolean(KEY_SCREEN_OFF, value).apply()

    /** Whether protection is enabled (used to restart after boot). */
    var serviceEnabled: Boolean
        get() = prefs.getBoolean(KEY_ENABLED, false)
        set(value) = prefs.edit().putBoolean(KEY_ENABLED, value).apply()

    companion object {
        private const val NAME = "applock_native"
        private const val KEY_LOCKED = "locked_packages"
        private const val KEY_DELAY = "relock_delay_ms"
        private const val KEY_SCREEN_OFF = "relock_on_screen_off"
        private const val KEY_ENABLED = "service_enabled"
    }
}
