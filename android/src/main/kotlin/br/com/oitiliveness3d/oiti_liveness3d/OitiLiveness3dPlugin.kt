package br.com.oitiliveness3d.oiti_liveness3d

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3d
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3dException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class OitiLiveness3dPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    companion object {
        private const val L3_RESULT_REQUEST = 9564
    }

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var result: Result
    private var activity: Activity? = null
    private var manager: AltLiveness3d? = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "oiti_liveness3d")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result

        when (call.method) {
            "OITI.startLiveness3d" -> {
                val appKey = call.argument<String>("appkey")
                val environment = call.argument<String>("environment")
                val textsBuilder = call.argument<Map<String, String?>>("texts")
                val themeBuilder = call.argument<Map<String, String?>>("theme")
                val fontsBuilder = call.argument<Map<String, String?>>("fonts")
                val loading = call.argument<Map<String, Any?>>("loading")
                startLiveness3d(appKey, environment, textsBuilder, themeBuilder, fontsBuilder, loading)
            }

            "OITI.checkPermission" -> {
                checkPermission()
            }

            "OITI.askPermission" -> {
                askPermission()
            }

            "OITI.eventLog" -> {
                val event = call.argument<String>("event")
                val appKey = call.argument<String>("appkey") ?: ""
                logEvent(event, appKey)
            }

            else -> { result.notImplemented() }
        }
    }

    private fun startLiveness3d(
        appKey: String?,
        environment: String?,
        textsBuilder: Map<String, String?>?,
        themeBuilder: Map<String, String?>?,
        fontsBuilder: Map<String, String?>?,
        loadingAppearance: Map<String, Any?>?
    ){
        try {
            manager = AltLiveness3d(context, result, appKey, environment, textsBuilder, themeBuilder, fontsBuilder, loadingAppearance)
            val intent = manager?.getIntent()
            activity?.startActivityForResult(intent, L3_RESULT_REQUEST)
        } catch (e: AltLiveness3dException) {
            result.error(e.code, e.message, null)
        } catch (e: Exception) {
            result.error("UNKNOWN_ERROR", e.message, e.stackTrace)
        }
    }

    private fun logEvent(name: String?, appKey: String) {
        
    }

    private fun checkPermission() {
        result.success(true)
    }

    private fun askPermission() {
        result.success(true)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == L3_RESULT_REQUEST) {
            when(resultCode) {
                Activity.RESULT_OK -> manager?.onLiveness3DResultSuccess(data)
                Activity.RESULT_CANCELED -> manager?.onLiveness3DResultCancelled(data)
            }
            return true
        }
        return false
    }
}
