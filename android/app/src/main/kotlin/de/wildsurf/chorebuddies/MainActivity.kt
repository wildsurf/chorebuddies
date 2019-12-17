package de.wildsurf.chorebuddies

import android.os.Build
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun onFlutterUiDisplayed() {
        if (Build.VERSION.SDK_INT == Build.VERSION_CODES.KITKAT) {
            return
        }
        super.onFlutterUiDisplayed()
    }
}
