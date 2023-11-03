class Liveness3dFonts {
  /* Guidance */
  String? guidanceCustomizationHeaderFont;
  String? guidanceCustomizationSubtextFont;

  /* Button */
  String? guidanceCustomizationButtonFont;

  /* Ready Screen */
  String? readyScreenCustomizationHeaderFont;
  String? readyScreenCustomizationSubtextFont;

  /* Retry Screen */
  String? retryScreenCustomizationHeaderFont;
  String? retryScreenCustomizationSubtextFont;

  /* Result Screen */
  String? resultScreenCustomizationMessageFont;

  /* Feedback */
  String? feedbackCustomizationTextFont;

  Map toJson() => {
        'guidanceCustomizationHeaderFont':
            guidanceCustomizationHeaderFont ?? '',
        'guidanceCustomizationSubtextFont':
            guidanceCustomizationSubtextFont ?? '',
        'guidanceCustomizationButtonFont':
            guidanceCustomizationButtonFont ?? '',
        'readyScreenCustomizationHeaderFont':
            readyScreenCustomizationHeaderFont ?? '',
        'readyScreenCustomizationSubtextFont':
            readyScreenCustomizationSubtextFont ?? '',
        'retryScreenCustomizationHeaderFont':
            retryScreenCustomizationHeaderFont ?? '',
        'retryScreenCustomizationSubtextFont':
            retryScreenCustomizationSubtextFont ?? '',
        'resultScreenCustomizationMessageFont':
            resultScreenCustomizationMessageFont ?? '',
        'feedbackCustomizationTextFont': feedbackCustomizationTextFont ?? '',
      };
}
