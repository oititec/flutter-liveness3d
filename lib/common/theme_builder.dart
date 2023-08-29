class ThemeBuilder {
  /* Guidance */
  String? guidanceCustomizationBackgroundColors;
  String? guidanceCustomizationForegroundColor;

  /* Button */
  String? guidanceCustomizationButtonTextNormalColor;
  String? guidanceCustomizationButtonBackgroundNormalColor;
  String? guidanceCustomizationButtonTextHighlightColor;
  String? guidanceCustomizationButtonBackgroundHighlightColor;
  String? guidanceCustomizationButtonTextDisabledColor;
  String? guidanceCustomizationButtonBackgroundDisabledColor;
  String? guidanceCustomizationButtonBorderColor;
  String? guidanceCustomizationButtonBorderWidth;
  String? guidanceCustomizationButtonCornerRadius;

  /* Ready Screen */
  String? guidanceCustomizationReadyScreenHeaderTextColor;
  String? guidanceCustomizationReadyScreenSubtextTextColor;

  /* Retry Screen */
  String? guidanceCustomizationRetryScreenHeaderTextColor;
  String? guidanceCustomizationRetryScreenSubtextTextColor;
  String? guidanceCustomizationRetryScreenImageBorderColor;
  String? guidanceCustomizationRetryScreenImageBorderWidth;
  String? guidanceCustomizationRetryScreenImageCornerRadius;
  String? guidanceCustomizationRetryScreenOvalStrokeColor;

  /* Result Screen */
  String? resultScreenCustomizationForegroundColor;
  String? resultScreenCustomizationBackgroundColors;
  String? resultScreenCustomizationActivityIndicatorColor;
  String? resultScreenCustomizationCustomActivityIndicatorRotationIntervar;
  String? resultScreenCustomizationUploadProgressFillColor;
  String? resultScreenCustomizationUploadProgressTrackColor;
  String? resultScreenCustomizationResultAnimationBackgroundColor;
  String? resultScreenCustomizationResultAnimationForegroundColor;

  /* Oval */
  String? ovalCustomizationStrokeWidth;
  String? ovalCustomizationStrokeColor;
  String? ovalCustomizationProgressStrokeWidth;
  String? ovalCustomizationProgressColor1;
  String? ovalCustomizationProgressColor2;
  String? ovalCustomizationProgressRadialOffset;

  /* Frame */
  String? frameCustomizationBorderWidth;
  String? frameCustomizationCornerRadius;
  String? frameCustomizationBorderColor;
  String? frameCustomizationBackgroundColor;
  String? frameCustomizationElevation;

  /* Overlay */
  String? overlayCustomizationBackgroundColor;

  /* Feedback */
  String? feedbackCustomizationCornerRadius;
  String? feedbackCustomizationBackgroundColors;
  String? feedbackCustomizationTextColor;

  Map toJson() => {
        'guidanceCustomizationBackgroundColors':
            guidanceCustomizationBackgroundColors ?? '',
        'guidanceCustomizationForegroundColor':
            guidanceCustomizationForegroundColor ?? '',
        'guidanceCustomizationButtonTextNormalColor':
            guidanceCustomizationButtonTextNormalColor ?? '',
        'guidanceCustomizationButtonBackgroundNormalColor':
            guidanceCustomizationButtonBackgroundNormalColor ?? '',
        'guidanceCustomizationButtonTextHighlightColor':
            guidanceCustomizationButtonTextHighlightColor ?? '',
        'guidanceCustomizationButtonBackgroundHighlightColor':
            guidanceCustomizationButtonBackgroundHighlightColor ?? '',
        'guidanceCustomizationButtonTextDisabledColor':
            guidanceCustomizationButtonTextDisabledColor ?? '',
        'guidanceCustomizationButtonBackgroundDisabledColor':
            guidanceCustomizationButtonBackgroundDisabledColor ?? '',
        'guidanceCustomizationButtonBorderColor':
            guidanceCustomizationButtonBorderColor ?? '',
        'guidanceCustomizationButtonBorderWidth':
            guidanceCustomizationButtonBorderWidth ?? '',
        'guidanceCustomizationButtonCornerRadius':
            guidanceCustomizationButtonCornerRadius ?? '',
        'guidanceCustomizationReadyScreenHeaderTextColor':
            guidanceCustomizationReadyScreenHeaderTextColor ?? '',
        'guidanceCustomizationReadyScreenSubtextTextColor':
            guidanceCustomizationReadyScreenSubtextTextColor ?? '',
        'guidanceCustomizationRetryScreenHeaderTextColor':
            guidanceCustomizationRetryScreenHeaderTextColor ?? '',
        'guidanceCustomizationRetryScreenSubtextTextColor':
            guidanceCustomizationRetryScreenSubtextTextColor ?? '',
        'guidanceCustomizationRetryScreenImageBorderColor':
            guidanceCustomizationRetryScreenImageBorderColor ?? '',
        'guidanceCustomizationRetryScreenImageBorderWidth':
            guidanceCustomizationRetryScreenImageBorderWidth ?? '',
        'guidanceCustomizationRetryScreenImageCornerRadius':
            guidanceCustomizationRetryScreenImageCornerRadius ?? '',
        'guidanceCustomizationRetryScreenOvalStrokeColor':
            guidanceCustomizationRetryScreenOvalStrokeColor ?? '',
        'resultScreenCustomizationForegroundColor':
            resultScreenCustomizationForegroundColor ?? '',
        'resultScreenCustomizationBackgroundColors':
            resultScreenCustomizationBackgroundColors ?? '',
        'resultScreenCustomizationActivityIndicatorColor':
            resultScreenCustomizationActivityIndicatorColor ?? '',
        'resultScreenCustomizationCustomActivityIndicatorRotationIntervar':
            resultScreenCustomizationCustomActivityIndicatorRotationIntervar ??
                '',
        'resultScreenCustomizationUploadProgressFillColor':
            resultScreenCustomizationUploadProgressFillColor ?? '',
        'resultScreenCustomizationUploadProgressTrackColor':
            resultScreenCustomizationUploadProgressTrackColor ?? '',
        'resultScreenCustomizationResultAnimationBackgroundColor':
            resultScreenCustomizationResultAnimationBackgroundColor ?? '',
        'resultScreenCustomizationResultAnimationForegroundColor':
            resultScreenCustomizationResultAnimationForegroundColor ?? '',
        'ovalCustomizationStrokeWidth': ovalCustomizationStrokeWidth ?? '',
        'ovalCustomizationStrokeColor': ovalCustomizationStrokeColor ?? '',
        'ovalCustomizationProgressStrokeWidth':
            ovalCustomizationProgressStrokeWidth ?? '',
        'ovalCustomizationProgressColor1':
            ovalCustomizationProgressColor1 ?? '',
        'ovalCustomizationProgressColor2':
            ovalCustomizationProgressColor2 ?? '',
        'ovalCustomizationProgressRadialOffset':
            ovalCustomizationProgressRadialOffset ?? '',
        'frameCustomizationBorderWidth': frameCustomizationBorderWidth ?? '',
        'frameCustomizationCornerRadius': frameCustomizationCornerRadius ?? '',
        'frameCustomizationBorderColor': frameCustomizationBorderColor ?? '',
        'frameCustomizationBackgroundColor':
            frameCustomizationBackgroundColor ?? '',
        'frameCustomizationElevation': frameCustomizationElevation ?? '',
        'overlayCustomizationBackgroundColor':
            overlayCustomizationBackgroundColor ?? '',
        'feedbackCustomizationCornerRadius':
            feedbackCustomizationCornerRadius ?? '',
        'feedbackCustomizationBackgroundColors':
            feedbackCustomizationBackgroundColors ?? '',
        'feedbackCustomizationTextColor': feedbackCustomizationTextColor ?? '',
      };
}
