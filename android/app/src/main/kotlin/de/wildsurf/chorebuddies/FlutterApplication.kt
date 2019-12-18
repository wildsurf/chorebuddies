package de.wildsurf.chorebuddies

import android.content.Context
import android.os.Build
import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication

class FlutterApplication : FlutterApplication() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP) {
            MultiDex.install(this)
        }
    }
}