package br.com.oitiliveness3d.oiti_liveness3d.utils

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import br.com.oiti.liveness3d.app.ui.HybridLiveness3DActivity
import br.com.oiti.liveness3d.data.model.ENVIRONMENT3D
import br.com.oiti.liveness3d.data.model.Liveness3DUser
import br.com.oiti.liveness3d.data.model.LoadingType3D
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class AltLiveness3d(
    private var context: Context?,
    private val result: MethodChannel.Result,
    private val appKey: String?,
    private val baseUrl: String?,
    private val isProd: Boolean = false
) {

    private fun getUser(): Liveness3DUser {
        val env: ENVIRONMENT3D = if (isProd) ENVIRONMENT3D.PRD else ENVIRONMENT3D.HML

        return Liveness3DUser(
            appKey = appKey!!,
            environment = env
        )
    }

    fun getIntent(): Intent {

        if (appKey.isNullOrBlank()) {
            throw InvalidAppKey()
        }

        if (baseUrl.isNullOrBlank()) {
            throw InvalidBaseUrl()
        }

        return Intent(context, HybridLiveness3DActivity::class.java).apply {
            putExtra(HybridLiveness3DActivity.PARAM_ENDPOINT, baseUrl)
            putExtra(HybridLiveness3DActivity.PARAM_LIVENESS3D_USER, getUser())
            putExtra(HybridLiveness3DActivity.PARAM_DEBUG_ON, false)
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_BACKGROUND, "#000000")
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_SPINNER_COLOR, "#FFFFFF")
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_SIZE, 100)
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_TYPE, LoadingType3D.ACTIVITY_INDICATOR)
        }
    }

    fun onLiveness3DResultSuccess(data: Intent?) {
        val response = HashMap<String, Any?>().apply {
            put("result", data?.getBooleanExtra(HybridLiveness3DActivity.PARAM_RESULT, false))
            put("cause", data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_CAUSE))
            put("codId", data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_COD_ID))
            put("protocol", data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_PROTOCOL))
            put("scan", data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_SCAN))
            put("valid", data?.getBooleanExtra(HybridLiveness3DActivity.PARAM_RESULT_VALID, false))
        }
        result.success(response)
    }

    fun onLiveness3DResultCancelled(data: Intent?) {
        val errorMessage: String = data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_ERROR) ?: ""
        Log.d("TAG", errorMessage)
        result.error(errorMessage, errorMessage, null)
    }

}