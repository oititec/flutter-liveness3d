package br.com.oitiliveness3d.oiti_liveness3d.utils

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.util.Log
import br.com.oiti.liveness3d.app.ui.HybridLiveness3DActivity
import br.com.oiti.liveness3d.data.model.*
import br.com.oitiliveness3d.oiti_liveness3d.theme.Liveness3DTheme
import io.flutter.plugin.common.MethodChannel

class AltLiveness3d(
    private var context: Context,
    private val result: MethodChannel.Result?,
    private val appKey: String?,
    private val environment: String?,
    private val textsBuilder: Map<String, String?>?,
    private val themeBuilder: Map<String, String?>?,
    private val fontsBuilder: Map<String, String?>?,
    private val loadingAppearance: Map<String, Any?>?
) {

    private fun getUser(): Liveness3DUser {
        val env: ENVIRONMENT3D = if (environment.equals("PRD")) ENVIRONMENT3D.PRD else ENVIRONMENT3D.HML
        val theme = Liveness3DTheme(context, themeBuilder).apply()

        return Liveness3DUser(
            appKey = appKey!!,
            environment = env,
            liveness3DTheme = theme
        )
    }

    fun getIntent(): Intent {
        if (appKey.isNullOrBlank()) {
            throw InvalidAppKey()
        }

        val user = getUser()
        val endpoint = when(user.environment) {
            ENVIRONMENT3D.PRD -> "https://certiface.com.br"
            ENVIRONMENT3D.HML -> "https://comercial.certiface.com.br"
            else -> "https://comercial.certiface.com.br"
        }

        val texts = getTexts(textsBuilder)
        val fonts = getFonts(fontsBuilder)
        
        val loadingColor = (loadingAppearance?.get("foreground") ?: "#05D758") as String
        val loadingBackgroundColor = (loadingAppearance?.get("background") ?: "#FFFFFF") as String
        val loadingSize = (loadingAppearance?.get("size") ?: 1) as Int
        val loadingType = getLoadingType((loadingAppearance?.get("type") ?: "") as String)

        return Intent(context, HybridLiveness3DActivity::class.java).apply {
            putExtra(HybridLiveness3DActivity.PARAM_ENDPOINT, endpoint)
            putExtra(HybridLiveness3DActivity.PARAM_LIVENESS3D_USER, user)
            putExtra(HybridLiveness3DActivity.PARAM_DEBUG_ON, false)
            putExtra(HybridLiveness3DActivity.PARAM_TEXTS, texts)
            putExtra(HybridLiveness3DActivity.PARAM_FONTS, fonts)
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_SPINNER_COLOR, loadingColor)
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_BACKGROUND, loadingBackgroundColor)
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_SIZE, loadingSize * 100)
            putExtra(HybridLiveness3DActivity.PARAM_CUSTOM_LOADING_TYPE, loadingType)
        }
    }

    fun onLiveness3DResultSuccess(data: Intent?) {
        val response = mapOf<String, Any?>(
            "valid" to data?.getBooleanExtra(HybridLiveness3DActivity.PARAM_RESULT_VALID, false),
            "cause" to data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_CAUSE),
            "codId" to data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_COD_ID),
            "protocol" to data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_PROTOCOL),
            "blob" to data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_SCAN),
        )
        result?.success(response)
    }

    fun onLiveness3DResultCancelled(data: Intent?) {
        val errorMessage: String = data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_ERROR) ?: ""
        Log.d("TAG", errorMessage)
        result?.error(errorMessage, errorMessage, null)
    }

    private fun getFontKey(identifier: String): Liveness3DFontsKey? {
        return when(identifier) {
            /* Guidance */
            "guidanceCustomizationHeaderFont" -> Liveness3DFontsKey.GUIDANCE_CUSTOMIZATION_HEADER_FONT
            "guidanceCustomizationSubtextFont" -> Liveness3DFontsKey.GUIDANCE_CUSTOMIZATION_SUBTEXT_FONT
            /* Button */
            "guidanceCustomizationButtonFont" -> Liveness3DFontsKey.GUIDANCE_CUSTOMIZATION_BUTTON_FONT

            /* Ready Screen */
            "readyScreenCustomizationHeaderFont" -> Liveness3DFontsKey.GUIDANCE_CUSTOMIZATION_READY_SCREEN_HEADER_FONT
            "readyScreenCustomizationSubtextFont" -> Liveness3DFontsKey.GUIDANCE_CUSTOMIZATION_READY_SCREEN_SUBTEXT_FONT
            /* Retry Screen */
            "retryScreenCustomizationHeaderFont" -> Liveness3DFontsKey.GUIDANCE_CUSTOMIZATION_RETRY_SCREEN_HEADER_FONT
            "retryScreenCustomizationSubtextFont" -> Liveness3DFontsKey.GUIDANCE_CUSTOMIZATION_RETRY_SCREEN_SUBTEXT_FONT
            /* Result Screen */
            "resultScreenCustomizationMessageFont" -> Liveness3DFontsKey.RESULT_SCREEN_CUSTOMIZATION_MESSAGE_FONT
            /* Feedback */
            "feedbackCustomizationTextFont" -> Liveness3DFontsKey.FEEDBACK_CUSTOMIZATION_TEXT_FONT
            else -> null
        }
    }

    private fun getFonts(fontsBuilder: Map<String, String?>?): HashMap<Liveness3DFontsKey?, String?> {
        val hashMap = HashMap<Liveness3DFontsKey?, String?>()
        if (fontsBuilder != null) {
            val fontsMap = fontsBuilder
                .mapNotNull {
                    val key = getFontKey(it.key)
                    val value = it.value
                    if (value?.isEmpty() == true) {
                        null
                    } else { Pair(key, "fonts/$value.ttf".lowercase()) }
                }
                .toMap()
            hashMap.putAll(fontsMap)
            Log.d("HASH AQUII", hashMap.toString())
        }
        return hashMap
    }

    private fun getTextKey(identifier: String): Liveness3DTextKey? {
        return when(identifier) {
            /* Ready */
            "READY_HEADER_1" -> Liveness3DTextKey.READY_HEADER_1
            "READY_HEADER_2" -> Liveness3DTextKey.READY_HEADER_2
            "READY_MESSAGE_1" -> Liveness3DTextKey.READY_MESSAGE_1
            "READY_MESSAGE_2" -> Liveness3DTextKey.READY_MESSAGE_2
            "READY_BUTTON" -> Liveness3DTextKey.READY_BUTTON

            /* Retry */
            "RETRY_HEADER" -> Liveness3DTextKey.RETRY_HEADER
            "RETRY_SUBHEADER" -> Liveness3DTextKey.RETRY_SUBHEADER
            "RETRY_MESSAGE_SMILE" -> Liveness3DTextKey.RETRY_MESSAGE_SMILE
            "RETRY_MESSAGE_LIGHTING" -> Liveness3DTextKey.RETRY_MESSAGE_LIGHTING
            "RETRY_MESSAGE_CONTRAST" -> Liveness3DTextKey.RETRY_MESSAGE_CONTRAST
            "RETRY_YOUR_PICTURE" -> Liveness3DTextKey.RETRY_YOUR_PICTURE
            "RETRY_IDEAL_PICTURE" -> Liveness3DTextKey.RETRY_IDEAL_PICTURE
            "RETRY_BUTTON" -> Liveness3DTextKey.RETRY_BUTTON

            /* Result */
            "RESULT_UPLOAD_MESSAGE" -> Liveness3DTextKey.RESULT_UPLOAD_MESSAGE
            "RESULT_SUCCESS_MESSAGE" -> Liveness3DTextKey.RESULT_SUCCESS_MESSAGE

            /* Feedback */
            "FEEDBACK_POSITION_FACE_STRAIGHT_IN_OVAL" -> Liveness3DTextKey.FEEDBACK_LOOK_STRAIGHT_IN_OVAL
            "FEEDBACK_CENTER_FACE" -> Liveness3DTextKey.FEEDBACK_CENTER_FACE
            "FEEDBACK_FACE_NOT_FOUND" -> Liveness3DTextKey.FEEDBACK_FACE_NOT_FOUND
            "FEEDBACK_FACE_NOT_LOOKING_STRAIGHT_AHEAD" -> Liveness3DTextKey.FEEDBACK_FACE_NOT_LOOKING_STRAIGHT_AHEAD
            "FEEDBACK_FACE_NOT_UPRIGHT" -> Liveness3DTextKey.FEEDBACK_FACE_NOT_UPRIGHT
            "FEEDBACK_MOVE_PHONE_AWAY" -> Liveness3DTextKey.FEEDBACK_MOVE_PHONE_AWAY
            "FEEDBACK_MOVE_PHONE_CLOSER" -> Liveness3DTextKey.FEEDBACK_MOVE_PHONE_CLOSER
            "FEEDBACK_MOVE_PHONE_TO_EYE_LEVEL" -> Liveness3DTextKey.FEEDBACK_MOVE_PHONE_TO_EYE_LEVEL
            "FEEDBACK_USE_EVEN_LIGHTING" -> Liveness3DTextKey.FEEDBACK_USE_EVEN_LIGHTING
            "FEEDBACK_FRAME_YOUR_FACE" -> Liveness3DTextKey.FEEDBACK_FRAME_YOUR_FACE
            "FEEDBACK_HOLD_STEADY" -> Liveness3DTextKey.FEEDBACK_HOLD_STEADY
            "FEEDBACK_HOLD_STEADY_1" -> Liveness3DTextKey.FEEDBACK_HOLD_STEADY_1
            "FEEDBACK_HOLD_STEADY_2" -> Liveness3DTextKey.FEEDBACK_HOLD_STEADY_2
            "FEEDBACK_HOLD_STEADY_3" -> Liveness3DTextKey.FEEDBACK_HOLD_STEADY_3
            "FEEDBACK_REMOVE_DARK_GLASSES" -> Liveness3DTextKey.FEEDBACK_REMOVE_DARK_GLASSES
            "FEEDBACK_NEUTRAL_EXPRESSION" -> Liveness3DTextKey.FEEDBACK_NEUTRAL_EXPRESSION
            "FEEDBACK_CONDITIONS_TOO_BRIGHT" -> Liveness3DTextKey.FEEDBACK_CONDITIONS_TOO_BRIGHT
            "FEEDBACK_BRIGHTEN_YOUR_ENVIRONMENT" -> Liveness3DTextKey.FEEDBACK_BRIGHTEN_YOUR_ENVIRONMENT
            else -> null
        }
    }
    private fun getTexts(textsBuilder: Map<String, String?>?): HashMap<Liveness3DTextKey, String> {
        val hashMap = HashMap<Liveness3DTextKey, String>()
        if (textsBuilder != null) {
            val textsMap = textsBuilder
                .mapNotNull {
                    val key = getTextKey(it.key)
                    val value = it.value
                    if (key != null && value != null) {
                        Pair(key, value)
                    } else { null }
                }
                .toMap()
            hashMap.putAll(textsMap)
        }
        return hashMap
    }

    private fun getLoadingType(typeString: String): LoadingType3D {
        return when(typeString) {
            "spinner" -> LoadingType3D.SPINNER
            "activity" -> LoadingType3D.ACTIVITY_INDICATOR
            else -> LoadingType3D.ACTIVITY_INDICATOR
        }
    }
}
