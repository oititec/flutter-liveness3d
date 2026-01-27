    package br.com.oitiliveness3d.oiti_liveness3d.theme

    import android.content.Context
    import br.com.oiti.liveness3d.theme.Liveness3DTheme
    import br.com.oitiliveness3d.oiti_liveness3d.R

    class Liveness3DTheme(
        private var context: Context?,
        private var themeBuilder: Map<String, String?>?,
    ) {
        //Guidance customization
        private val guidanceCustomizationBackgroundColors: String? = themeBuilder?.get("guidanceCustomizationBackgroundColors") ?: "#FFFFFF"
        private val guidanceCustomizationForegroundColor: String? = themeBuilder?.get("guidanceCustomizationForegroundColor") ?: "#FFFFFF"

        //Buttons
        private val guidanceCustomizationButtonTextNormalColor: String? = themeBuilder?.get("guidanceCustomizationButtonTextNormalColor") ?: "#000000"
        private val guidanceCustomizationButtonBackgroundNormalColor: String? = themeBuilder?.get("guidanceCustomizationButtonBackgroundNormalColor") ?: "#05D758"
        private val guidanceCustomizationButtonTextHighlightColor: String? = themeBuilder?.get("guidanceCustomizationButtonTextHighlightColor") ?: "#FFFFFF"
        private val guidanceCustomizationButtonBackgroundHighlightColor: String? = themeBuilder?.get("guidanceCustomizationButtonBackgroundHighlightColor") ?: "#05D758"
        private val guidanceCustomizationButtonTextDisabledColor: String? = themeBuilder?.get("guidanceCustomizationButtonTextDisabledColor") ?: "#A3A3A3"
        private val guidanceCustomizationButtonBackgroundDisabledColor: String? = themeBuilder?.get("guidanceCustomizationButtonBackgroundDisabledColor") ?: "#F5F5F5"
        private val guidanceCustomizationButtonBorderColor: String? = themeBuilder?.get("guidanceCustomizationButtonBorderColor") ?: "#000000"
        private val guidanceCustomizationButtonBorderWidth: Int? = themeBuilder?.get("guidanceCustomizationButtonBorderWidth")?.toInt() ?: 0
        private val guidanceCustomizationButtonCornerRadius: Int? = themeBuilder?.get("guidanceCustomizationButtonCornerRadius")?.toInt() ?: 25

        //Ready Screen
        private val guidanceCustomizationReadyScreenHeaderTextColor: String? = themeBuilder?.get("guidanceCustomizationReadyScreenHeaderTextColor") ?: "#000000"
        private val guidanceCustomizationReadyScreenSubtextTextColor: String? = themeBuilder?.get("guidanceCustomizationReadyScreenSubtextTextColor") ?: "#666666"

        //Retry Screen
        private val guidanceCustomizationRetryScreenHeaderTextColor: String? = themeBuilder?.get("guidanceCustomizationRetryScreenHeaderTextColor") ?: "#000000"
        private val guidanceCustomizationRetryScreenSubtextTextColor: String? = themeBuilder?.get("guidanceCustomizationRetryScreenSubtextTextColor") ?: "#666666"
        private val guidanceCustomizationRetryScreenImageBorderColor: String? = themeBuilder?.get("guidanceCustomizationRetryScreenImageBorderColor") ?: "#05D758"
        private val guidanceCustomizationRetryScreenImageBorderWidth: Int? = themeBuilder?.get("guidanceCustomizationRetryScreenImageBorderWidth")?.toInt() ?: 0
        private val guidanceCustomizationRetryScreenImageCornerRadius: Int? = themeBuilder?.get("guidanceCustomizationRetryScreenImageCornerRadius")?.toInt() ?: 16
        private val guidanceCustomizationRetryScreenOvalStrokeColor: String? = themeBuilder?.get("guidanceCustomizationRetryScreenOvalStrokeColor")  ?: "#05D758"
        // private val guidanceCustomizationReadyScreenOvalFillColor: String? = themeBuilder?.get("guidanceCustomizationReadyScreenOvalFillColor") ?: "#000000"
        // private val guidanceCustomizationReadyScreenTextBackgroundColor: String? = themeBuilder?.get("guidanceCustomizationReadyScreenTextBackgroundColor") ?: "#05D758"
        // private val guidanceCustomizationReadyScreenTextBackgroundCornerRadius: Int? = themeBuilder?.get("guidanceCustomizationReadyScreenTextBackgroundCornerRadius")?.toInt() ?: 0

        //Result Screen Customization
        private val resultScreenCustomizationAnimationRelativeScale: Float = 1.0F
        private val resultScreenCustomizationForegroundColor: String = themeBuilder?.get("resultScreenCustomizationForegroundColor") ?: "#09244F"
        private val resultScreenCustomizationBackgroundColors: String = themeBuilder?.get("resultScreenCustomizationBackgroundColors") ?: "#FFFFFF"
        private val resultScreenCustomizationUploadProgressFillColor: String = themeBuilder?.get("resultScreenCustomizationUploadProgressFillColor") ?: "#05D758"
        private val resultScreenCustomizationUploadProgressTrackColor: String = themeBuilder?.get("resultScreenCustomizationUploadProgressTrackColor") ?: "#E0E0E0"
        private val resultScreenCustomizationActivityIndicatorColor: String = themeBuilder?.get("resultScreenCustomizationActivityIndicatorColor") ?: "#05D758"
        private val resultScreenCustomizationResultAnimationBackgroundColor: String = themeBuilder?.get("resultScreenCustomizationResultAnimationBackgroundColor") ?: "#05D758"
        private val resultScreenCustomizationResultAnimationForegroundColor: String = themeBuilder?.get("resultScreenCustomizationResultAnimationForegroundColor") ?: "#F5F5F5"
        private val resultScreenCustomizationResultAnimationBackgroundImage: String = themeBuilder?.get("resultScreenCustomizationResultAnimationBackgroundImage") ?: ""
        // @DrawableRes
        // private val resultScreenCustomizationCustomActivityIndicatorImage: Int? = null
        // private val resultScreenCustomizationCustomActivityIndicatorRotationInterval: Int = 1000
        // private val resultScreenCustomizationCustomActivityIndicatorAnimation: Int = 0
        // private val resultScreenCustomizationShowUploadProgressBar: Boolean = true

/*
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
 */

          //Oval Customization
          private val ovalCustomizationStrokeWidth: Int? = themeBuilder?.get("ovalCustomizationStrokeWidth")?.toInt() ?: 3
          private val ovalCustomizationStrokeColor: String? = themeBuilder?.get("ovalCustomizationStrokeColor") ?: "#05D758"
          private val ovalCustomizationProgressStrokeWidth: Int? = themeBuilder?.get("ovalCustomizationProgressStrokeWidth")?.toInt() ?: 2
          private val ovalCustomizationProgressColor1: String? = themeBuilder?.get("ovalCustomizationProgressColor1") ?: "#05D758"
          private val ovalCustomizationProgressColor2: String? = themeBuilder?.get("ovalCustomizationProgressColor2") ?: "#05D758"
          private val ovalCustomizationProgressRadialOffset: Int? = themeBuilder?.get("ovalCustomizationProgressRadialOffset")?.toInt() ?: 2

          //Frame Customization
          private val frameCustomizationBorderWidth: Int? = themeBuilder?.get("frameCustomizationBorderWidth")?.toInt() ?: 0
          private val frameCustomizationCornerRadius: Int? = themeBuilder?.get("frameCustomizationCornerRadius")?.toInt() ?: 0
          private val frameCustomizationBorderColor: String? = themeBuilder?.get("frameCustomizationBorderColor") ?: "#05D758"
          private val frameCustomizationBackgroundColor: String? = themeBuilder?.get("frameCustomizationBackgroundColor") ?: "#FFFFFF"
          private val frameCustomizationElevation: Int? = themeBuilder?.get("frameCustomizationElevation")?.toInt() ?: 0

          //Overlay Customization
          private val overlayCustomizationBackgroundColor: String? = themeBuilder?.get("overlayCustomizationBackgroundColor") ?: "#FFFFFF"
        /*
          @DrawableRes
          private val overlayCustomizationBrandingImage: Int? = 0
          private val overlayCustomizationShowBrandingImage: Boolean = false
*/
          //Feedback Customization
          private val feedbackCustomizationCornerRadius: Int? = themeBuilder?.get("feedbackCustomizationCornerRadius")?.toInt() ?: 10
          private val feedbackCustomizationBackgroundColors: String? = themeBuilder?.get("feedbackCustomizationBackgroundColors") ?: "#000000"
          private val feedbackCustomizationTextColor: String? = themeBuilder?.get("feedbackCustomizationTextColor") ?: "#FFFFFF"
        /*
          private val feedbackCustomizationEnablePulsatingText: Boolean = true
          private val feedbackCustomizationElevation: Int? = 10

          */
/*
          //Cancel Button Customization
          @DrawableRes
          private val cancelButtonCustomizationCustomImage: Int? = R.drawable.return_button
          private val cancelButtonCustomizationLocation: Liveness3DButtonLocation? = Liveness3DButtonLocation.TOP_LEFT

          //Exit Animation Style
          private val exitAnimationStyle: Liveness3DExitAnimationStyle? = Liveness3DExitAnimationStyle.RIPPLE_IN

          private val resultScreenOverrideSuccessMessage: String? = null

          */

         fun apply(): Liveness3DTheme {
            val successImageId = context?.let {
                val id = it.resources?.getIdentifier(
                    resultScreenCustomizationResultAnimationBackgroundImage,
                    "drawable",
                    it.packageName
                )
                if (id != 0) id else R.drawable.success_icon
            } ?: R.drawable.success_icon
            return Liveness3DTheme.Builder()
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
                .resultScreenCustomizationResultAnimationSuccessBackgroundImage(successImageId)
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
                // .frameCustomizationElevation(frameCustomizationElevation)

                //Overlay
                .overlayCustomizationBackgroundColor(overlayCustomizationBackgroundColor)

                //Feedback Screen
                .feedbackCustomizationCornerRadius(feedbackCustomizationCornerRadius)
                .feedbackCustomizationBackgroundColors(feedbackCustomizationBackgroundColors)
                .feedbackCustomizationTextColor(feedbackCustomizationTextColor)

                .build()
        }
    }