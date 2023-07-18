package br.com.oitiliveness3d.oiti_liveness3d

import android.app.Activity
import android.content.Context
import br.com.oiti.security.observability.firebase.FirebaseEvents
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3d
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3dException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class OitiLiveness3dPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel

    private lateinit var context: Context
    private lateinit var activity: Activity

    private var resultReference: Result? = null
    private val D3_RESULT_REQUEST = 9564

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
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
        when (call.method) {
            "OITI.startLiveness3d" -> {
                resultReference = result
                val appKey = call.argument<String>("appkey")
                val environment = call.argument<String>("environment")
                val textsBuilder = call.argument<Map<String, String?>>("texts")
                startLiveness3d(appKey, environment, textsBuilder)
            }

            "OITI.checkPermission" -> {
                resultReference = result
                checkPermission()
            }

            "OITI.askPermission" -> {
                resultReference = result
                askPermission()
            }

            "OITI.eventLog" -> {
                resultReference = result
                val event = call.argument<String>("event")
                logEvent(event, "")
            }

            else -> { result.notImplemented() }
        }
    }

    private fun startLiveness3d(appKey: String?, environment: String?, textsBuilder: Map<String, String?>?) {
        try {
            val intent = AltLiveness3d(context, resultReference, appKey, environment, textsBuilder).getIntent()
            activity.startActivityForResult(intent, D3_RESULT_REQUEST)
        } catch (e: AltLiveness3dException) {
            resultReference?.error(e.code, e.message, null)
        } catch (e: Exception) {
            resultReference?.error("UNKNOWN_ERROR", e.message, e.stackTrace)
        }
    }

    private fun logEvent(name: String?, appKey: String) {
        FirebaseEvents(name.toString(), appKey).apply()
    }

    private fun checkPermission() {
        resultReference?.success(true)
    }

    private fun askPermission() {
        resultReference?.success(true)
    }
}
