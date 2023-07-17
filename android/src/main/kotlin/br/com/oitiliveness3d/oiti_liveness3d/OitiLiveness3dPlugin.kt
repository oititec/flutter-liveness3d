package br.com.oitiliveness3d.oiti_liveness3d


import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.activity.result.ActivityResult
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity
import br.com.oiti.liveness3d.app.ui.HybridLiveness3DActivity
import br.com.oiti.liveness3d.data.model.ENVIRONMENT3D
import br.com.oiti.liveness3d.data.model.Liveness3DUser
import br.com.oiti.security.observability.firebase.FirebaseEvents
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3d
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3dException
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.ObjectOutput
import java.util.Objects


class OitiLiveness3dPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var context: Context? = null
    private val D3_RESULT_REQUEST = 9564
    private var activity: Activity? = null
    private var resultReference: Result? = null
    private var altLiveness3d: AltLiveness3d? = null

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

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "oiti_liveness3d")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
      when (call.method) {
          "OITI.startLiveness3d" -> {
              resultReference = result
              val appKey = call.argument<String>("appKey")
              val baseUrl = call.argument<String>("baseUrl")
              val isProd = call.argument<Boolean>("isProd")
              startLiveness3d(appKey, baseUrl, isProd)
          }
          "OITI.checkPermission" -> {
              resultReference = result
              checkpermission()
          }
          "OITI.askPermission" -> {
              resultReference = result
              askpermission()
          }
          "OITI.eventLog" -> {
              resultReference = result
              val event = call.argument<String>("event")
              logevent(event, "")

          }
          else -> {
              result.notImplemented()
          }
      }
  }

    private fun startLiveness3d(appKey: String?, baseUrl: String?, isProd: Boolean?) {

        try {
            altLiveness3d = AltLiveness3d(context!!, resultReference!!, appKey, baseUrl, isProd ?: false)
            val intent = altLiveness3d?.getIntent()
            activity?.startActivityForResult(intent, D3_RESULT_REQUEST)

        } catch (e: AltLiveness3dException) {
            resultReference?.error(e.code, e.message, null)

        } catch (e: Exception) {
            resultReference?.error("UNKNOWN_ERROR", e.message, e.stackTrace)
        }

    }

    private fun logevent(name: String?, appKey: String) {
        FirebaseEvents(name.toString(), appKey).apply()

    }

    private fun checkpermission() {
        resultReference?.success(true)
    }

    private fun askpermission() {
        resultReference?.success(true)
    }



  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
