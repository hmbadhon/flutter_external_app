package me.hmbadhon.flutter_external_app

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.Uri
import java.net.URISyntaxException
import android.content.Context

/** FlutterExternalAppPlugin */
class FlutterExternalAppPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "me.hmbadhon.flutter_external_app")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "sendToExternalApp" -> {
                val message = call.arguments as String
                // Handle the message received from Flutter
                println("Received message from Flutter: $message")
                if (message != null) {
                    openApp(message)
                }
                // Send a response back to Flutter
                result.success("Message received by Kotlin")
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun openApp(androidIntentUrl: String?) {
        if (androidIntentUrl != null) {
            try {
                val launchIntent = Intent.parseUri(androidIntentUrl, Intent.URI_INTENT_SCHEME)
                launchIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                val context = context.startActivity(launchIntent)
            } catch (e: URISyntaxException) {
                e.printStackTrace()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
