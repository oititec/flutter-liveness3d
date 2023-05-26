package br.com.oitiliveness3d.oiti_liveness3d

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Objects

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.*
import br.com.oiti.liveness3d.app.ui.HybridLiveness3DActivity
import br.com.oiti.liveness3d.data.model.ENVIRONMENT3D
import br.com.oiti.liveness3d.data.model.Liveness3DTextKey
import br.com.oiti.liveness3d.data.model.Liveness3DUser
import br.com.oiti.security.observability.firebase.FirebaseEvents
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3d
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3dException


/** OitiLiveness3dPlugin */
class OitiLiveness3dPlugin: FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var context: Context? = null
    private val D3_RESULT_REQUEST = 9564
    private var activity: Activity? = null
    private var resultReference: Result? = null
    private var altLiveness3d: AltLiveness3d? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "oiti_liveness3d")
    channel.setMethodCallHandler(this)
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
            resultReference?.error("UNKNOWN_ERROR", e.message, e.stackTrace.toString())

        }
    }

    private fun logevent(name: String?, appKey: String) {
        FirebaseEvents(name.toString(), appKey).apply()

    }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
