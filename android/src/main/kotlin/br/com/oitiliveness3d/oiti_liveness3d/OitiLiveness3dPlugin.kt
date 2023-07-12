package br.com.oitiliveness3d.oiti_liveness3d


import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import br.com.oiti.liveness3d.app.ui.HybridLiveness3DActivity
import br.com.oiti.liveness3d.data.model.ENVIRONMENT3D
import br.com.oiti.liveness3d.data.model.Liveness3DUser
import br.com.oiti.security.observability.firebase.FirebaseEvents
import br.com.oitiliveness3d.oiti_liveness3d.utils.AltLiveness3d
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.ObjectOutput
import java.util.Objects


class OitiLiveness3dPlugin: FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private val context: Context? = null
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

            val env: ENVIRONMENT3D = if (isProd == true) ENVIRONMENT3D.PRD else ENVIRONMENT3D.HML

            val liveness3DUser = Liveness3DUser(
                appKey = appKey!!,
                environment = env
            )
            Intent(context, HybridLiveness3DActivity::class.java).apply {
                putExtra(HybridLiveness3DActivity.PARAM_LIVENESS3D_USER, liveness3DUser)
             //   putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_BACKGROUND, loading["backgroundColor"])
             //   putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_SPINNER_COLOR, loadingColor)
              //  putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_SIZE, size)
              //  if(type == "default"){
              //      putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_TYPE, LoadingType3D.ACTIVITY_INDICATOR)
              //  }else{
              //      putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_TYPE, LoadingType3D.SPINNER)
              //  }
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
