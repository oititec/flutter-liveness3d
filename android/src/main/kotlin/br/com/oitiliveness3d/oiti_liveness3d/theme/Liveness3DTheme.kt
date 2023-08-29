package br.com.oitiliveness3d.oiti_liveness3d.theme

import androidx.annotation.DrawableRes
import br.com.oiti.liveness3d.R
import br.com.oiti.liveness3d.theme.Liveness3DButtonLocation
import br.com.oiti.liveness3d.theme.Liveness3DExitAnimationStyle
import br.com.oiti.liveness3d.theme.Liveness3DTheme

class Liveness3DTheme(
    private val textsBuilder: Map<String, String?>?,
    //Guidance customization
) {
    private val guidanceCustomizationBackgroundColors: String? = textsBuilder?.get("guidanceCustomizationBackgroundColors")
    private val guidanceCustomizationForegroundColor: String? = textsBuilder?.get("guidanceCustomizationForegroundColor")

    //Buttons
    private val guidanceCustomizationButtonTextNormalColor: String? = textsBuilder?.get("guidanceCustomizationForegroundColor")
    private val guidanceCustomizationButtonBackgroundNormalColor: String? = textsBuilder?.get("guidanceCustomizationButtonBackgroundNormalColor")
    private val guidanceCustomizationButtonTextHighlightColor: String? = textsBuilder?.get("guidanceCustomizationButtonTextHighlightColor")
    private val guidanceCustomizationButtonBackgroundHighlightColor: String? = textsBuilder?.get("guidanceCustomizationButtonBackgroundHighlightColor")
    private val guidanceCustomizationButtonTextDisabledColor: String? = textsBuilder?.get("guidanceCustomizationButtonTextDisabledColor")
    private val guidanceCustomizationButtonBackgroundDisabledColor: String? = textsBuilder?.get("guidanceCustomizationButtonBackgroundDisabledColor")
    private val guidanceCustomizationButtonBorderColor: String? = textsBuilder?.get("guidanceCustomizationButtonBorderColor")
    private val guidanceCustomizationButtonBorderWidth: Int? = textsBuilder?.get("guidanceCustomizationButtonBorderWidth")?.toInt()
    private val guidanceCustomizationButtonCornerRadius: Int? = textsBuilder?.get("guidanceCustomizationButtonCornerRadius")?.toInt()

    //Ready Screen
    private val guidanceCustomizationReadyScreenHeaderTextColor: String? = textsBuilder?.get("guidanceCustomizationReadyScreenHeaderTextColor")
    private val guidanceCustomizationReadyScreenSubtextTextColor: String? = textsBuilder?.get("guidanceCustomizationReadyScreenSubtextTextColor")

    //Retry Screen
    private val guidanceCustomizationRetryScreenHeaderTextColor: String? = textsBuilder?.get("guidanceCustomizationRetryScreenHeaderTextColor")
    private val guidanceCustomizationRetryScreenSubtextTextColor: String? = textsBuilder?.get("guidanceCustomizationRetryScreenSubtextTextColor")
    private val guidanceCustomizationReadyScreenOvalFillColor: String? = textsBuilder?.get("guidanceCustomizationReadyScreenOvalFillColor")
    private val guidanceCustomizationReadyScreenTextBackgroundColor: String? = textsBuilder?.get("guidanceCustomizationReadyScreenTextBackgroundColor")
    private val guidanceCustomizationReadyScreenTextBackgroundCornerRadius: Int? = textsBuilder?.get("guidanceCustomizationReadyScreenTextBackgroundCornerRadius")?.toInt()
    private val guidanceCustomizationRetryScreenImageBorderColor: String? = null
    private val guidanceCustomizationRetryScreenImageBorderWidth: Int? = textsBuilder?.get("guidanceCustomizationRetryScreenImageBorderWidth")?.toInt()
    private val guidanceCustomizationRetryScreenImageCornerRadius: Int? = textsBuilder?.get("guidanceCustomizationRetryScreenImageCornerRadius")?.toInt()
    private val guidanceCustomizationRetryScreenOvalStrokeColor: String? = textsBuilder?.get("guidanceCustomizationRetryScreenOvalStrokeColor")

    //Result Screen Customization
    private val resultScreenCustomizationAnimationRelativeScale: Float = 1.0F
    private val resultScreenCustomizationForegroundColor: String? = textsBuilder?.get("resultScreenCustomizationForegroundColor")
    private val resultScreenCustomizationBackgroundColors: String? = textsBuilder?.get("resultScreenCustomizationBackgroundColors")
    private val resultScreenCustomizationActivityIndicatorColor: String? = textsBuilder?.get("resultScreenCustomizationActivityIndicatorColor")
    @DrawableRes
    private val resultScreenCustomizationCustomActivityIndicatorImage: Int? = null
    private val resultScreenCustomizationCustomActivityIndicatorRotationInterval: Int = 1000
    private val resultScreenCustomizationCustomActivityIndicatorAnimation: Int = 0
    private val resultScreenCustomizationShowUploadProgressBar: Boolean = true
    private val resultScreenCustomizationUploadProgressFillColor: String? = textsBuilder?.get("resultScreenCustomizationUploadProgressFillColor")
    private val resultScreenCustomizationUploadProgressTrackColor: String? = textsBuilder?.get("resultScreenCustomizationUploadProgressTrackColor")
    private val resultScreenCustomizationResultAnimationBackgroundColor: String? = textsBuilder?.get("resultScreenCustomizationResultAnimationBackgroundColor")
    private val resultScreenCustomizationResultAnimationForegroundColor: String? = textsBuilder?.get("resultScreenCustomizationResultAnimationForegroundColor")
    @DrawableRes
    private val resultScreenCustomizationResultAnimationSuccessBackgroundImage: Int = 0
    @DrawableRes
    private val resultScreenCustomizationResultAnimationUnSuccessBackgroundImage: Int = 0
    @DrawableRes
    private val resultScreenCustomizationCustomResultAnimationSuccess: Int = 0
    @DrawableRes
    private val resultScreenCustomizationCustomResultAnimationUnSuccess: Int = 0
    @DrawableRes
    private val resultScreenCustomizationCustomStaticResultAnimationSuccess: Int = 0
    @DrawableRes
    private val resultScreenCustomizationCustomStaticResultAnimationUnSuccess: Int = 0

    //Oval Customization
    private val ovalCustomizationStrokeWidth: Int? = null
    private val ovalCustomizationStrokeColor: String? = null
    private val ovalCustomizationProgressStrokeWidth: Int? = null
    private val ovalCustomizationProgressColor1: String? = null
    private val ovalCustomizationProgressColor2: String? = null
    private val ovalCustomizationProgressRadialOffset: Int? = null

    //Frame Customization
    private val frameCustomizationBorderWidth: Int? = null
    private val frameCustomizationCornerRadius: Int? = null
    private val frameCustomizationBorderColor: String? = null
    private val frameCustomizationBackgroundColor: String? = null
    private val frameCustomizationElevation: Int? = 0

    //Overlay Customization
    private val overlayCustomizationBackgroundColor: String? = null
    @DrawableRes
    private val overlayCustomizationBrandingImage: Int? = 0
    private val overlayCustomizationShowBrandingImage: Boolean = false

    //Feedback Customization
    private val feedbackCustomizationCornerRadius: Int? = 0
    private val feedbackCustomizationBackgroundColors: String? = ""
    private val feedbackCustomizationTextColor: String? = null
    private val feedbackCustomizationEnablePulsatingText: Boolean = true
    private val feedbackCustomizationElevation: Int? = 10

    //Cancel Button Customization
    @DrawableRes
    private val cancelButtonCustomizationCustomImage: Int? = R.drawable.return_button
    private val cancelButtonCustomizationLocation: Liveness3DButtonLocation? = Liveness3DButtonLocation.TOP_LEFT

    //Exit Animation Style
    private val exitAnimationStyle: Liveness3DExitAnimationStyle? = Liveness3DExitAnimationStyle.RIPPLE_IN

    private val resultScreenOverrideSuccessMessage: String? = null

    private val liveness3DTheme =
        Liveness3DTheme
            .Builder()
            //Guidance
            .guidanceCustomizationBackgroundColors(guidanceCustomizationBackgroundColors)
            .guidanceCustomizationForegroundColor(guidanceCustomizationForegroundColor)

            //Botões
            .guidanceCustomizationButtonTextNormalColor(guidanceCustomizationButtonTextNormalColor)
            .guidanceCustomizationButtonBackgroundNormalColor(guidanceCustomizationButtonBackgroundNormalColor)
            .guidanceCustomizationButtonTextHighlightColor(guidanceCustomizationButtonTextHighlightColor)
            .guidanceCustomizationButtonBackgroundHighlightColor(guidanceCustomizationButtonBackgroundHighlightColor)
            .guidanceCustomizationButtonTextDisabledColor(guidanceCustomizationButtonTextDisabledColor)
            .guidanceCustomizationButtonBackgroundDisabledColor(guidanceCustomizationButtonBackgroundDisabledColor)
            .guidanceCustomizationButtonBorderColor(guidanceCustomizationButtonBorderColor)
            .guidanceCustomizationButtonBorderWidth(guidanceCustomizationButtonBorderWidth)
            .guidanceCustomizationButtonCornerRadius(guidanceCustomizationButtonCornerRadius)

            //Ready Screen
            .guidanceCustomizationReadyScreenHeaderTextColor(guidanceCustomizationReadyScreenHeaderTextColor)
            .guidanceCustomizationReadyScreenSubtextTextColor(guidanceCustomizationReadyScreenSubtextTextColor)

            //Retry Screen
            .guidanceCustomizationRetryScreenHeaderTextColor(guidanceCustomizationRetryScreenHeaderTextColor)
            .guidanceCustomizationRetryScreenSubtextTextColor(guidanceCustomizationRetryScreenSubtextTextColor)
            .guidanceCustomizationRetryScreenImageBorderColor(guidanceCustomizationRetryScreenImageBorderColor)
            .guidanceCustomizationRetryScreenImageBorderWidth(guidanceCustomizationRetryScreenImageBorderWidth)
            .guidanceCustomizationRetryScreenImageCornerRadius(guidanceCustomizationRetryScreenImageCornerRadius)
            .guidanceCustomizationRetryScreenOvalStrokeColor(guidanceCustomizationRetryScreenOvalStrokeColor)

            //Result Screen
            .resultScreenCustomizationAnimationRelativeScale(resultScreenCustomizationAnimationRelativeScale)
            .resultScreenCustomizationForegroundColor(resultScreenCustomizationForegroundColor)
            .resultScreenCustomizationBackgroundColors(resultScreenCustomizationBackgroundColors)
            .resultScreenCustomizationActivityIndicatorColor(resultScreenCustomizationActivityIndicatorColor)
            .resultScreenCustomizationUploadProgressFillColor(resultScreenCustomizationUploadProgressFillColor)
            .resultScreenCustomizationUploadProgressTrackColor(resultScreenCustomizationUploadProgressTrackColor)
            .resultScreenCustomizationResultAnimationBackgroundColor(resultScreenCustomizationResultAnimationBackgroundColor)
            .resultScreenCustomizationResultAnimationForegroundColor(resultScreenCustomizationResultAnimationForegroundColor)

            //Oval
            .ovalCustomizationStrokeWidth(ovalCustomizationStrokeWidth)
            .ovalCustomizationStrokeColor(ovalCustomizationStrokeColor)
            .ovalCustomizationProgressStrokeWidth(ovalCustomizationProgressStrokeWidth)
            .ovalCustomizationProgressColor1(ovalCustomizationProgressColor1)
            .ovalCustomizationProgressColor2(ovalCustomizationProgressColor2)
            .ovalCustomizationProgressRadialOffset(ovalCustomizationProgressRadialOffset)

            //Frame
            .frameCustomizationBorderWidth(frameCustomizationBorderWidth)
            .frameCustomizationCornerRadius(frameCustomizationCornerRadius)
            .frameCustomizationBorderColor(frameCustomizationBorderColor)
            .frameCustomizationBackgroundColor(frameCustomizationBackgroundColor)
            .frameCustomizationElevation(frameCustomizationElevation)

            //Overlay
            .overlayCustomizationBackgroundColor(overlayCustomizationBackgroundColor)

            //Feedback Screen
            .feedbackCustomizationCornerRadius(feedbackCustomizationCornerRadius)
            .feedbackCustomizationBackgroundColors(feedbackCustomizationBackgroundColors)
            .feedbackCustomizationTextColor(feedbackCustomizationTextColor)

            .build()

     fun apply(): Liveness3DTheme {
        return liveness3DTheme
    }
}