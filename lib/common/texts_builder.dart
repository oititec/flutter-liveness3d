class TextsBuilder {
  /* Ready Screen */
  String? readyHeader1;
  String? readyHeader2;
  String? readyMessage1;
  String? readyMessage2;
  String? readyButton;

  /* Retry Screen */
  String? retryHeader;
  String? retrySubheader;
  String? retryYourPicture;
  String? retryIdealPicture;
  String? retryMessageSmile;
  String? retryMessageLighting;
  String? retryMessageContrast;
  String? retryButton;

  /* Result Screen */
  String? resultUploadMessage;
  String? resultSuccessMessage;

  /* Feedback */
  String? feedbackCenterFace;
  String? feedbackFaceNotFound;
  String? feedbackFaceNotLookingStraightAhead;
  String? feedbackFaceNotUpright;
  String? feedbackHoldSteady;
  String? feedbackMovePhoneAway;
  String? feedbackMovePhoneCloser;
  String? feedbackMovePhoneToEyeLevel;
  String? feedbackUseEvenLighting;
  String? feedbackFrameYourFace;
  String? feedbackPositionFaceStraightInOval;
  String? feedbackHoldSteady1;
  String? feedbackHoldSteady2;
  String? feedbackHoldSteady3;
  String? feedbackRemoveDarkGlasses;
  String? feedbackNeutralExpression;
  String? feedbackConditionsTooBright;
  String? feedbackBrightenYourEnvironment;

  Map toJson() => {
        'READY_HEADER_1': readyHeader1 ?? '',
        'READY_HEADER_2': readyHeader2 ?? '',
        'READY_MESSAGE_1': readyMessage1 ?? '',
        'READY_MESSAGE_2': readyMessage2 ?? '',
        'READY_BUTTON': readyButton ?? '',
        'RETRY_HEADER': retryHeader ?? '',
        'RETRY_SUBHEADER': retrySubheader ?? '',
        'RETRY_YOUR_PICTURE': retryYourPicture ?? '',
        'RETRY_IDEAL_PICTURE': retryIdealPicture ?? '',
        'RETRY_MESSAGE_SMILE': retryMessageSmile ?? '',
        'RETRY_MESSAGE_LIGHTING': retryMessageLighting ?? '',
        'RETRY_MESSAGE_CONTRAST': retryMessageContrast ?? '',
        'RETRY_BUTTON': retryButton ?? '',
        'RESULT_UPLOAD_MESSAGE': resultUploadMessage ?? '',
        'RESULT_SUCCESS_MESSAGE': resultSuccessMessage ?? '',
        'FEEDBACK_CENTER_FACE': feedbackCenterFace ?? '',
        'FEEDBACK_FACE_NOT_FOUND': feedbackFaceNotFound ?? '',
        'FEEDBACK_FACE_NOT_LOOKING_STRAIGHT_AHEAD':
            feedbackFaceNotLookingStraightAhead ?? '',
        'FEEDBACK_FACE_NOT_UPRIGHT': feedbackFaceNotUpright ?? '',
        'FEEDBACK_HOLD_STEADY': feedbackHoldSteady ?? '',
        'FEEDBACK_HOLD_STEADY_1': feedbackHoldSteady1 ?? '',
        'FEEDBACK_HOLD_STEADY_2': feedbackHoldSteady2 ?? '',
        'FEEDBACK_HOLD_STEADY_3': feedbackHoldSteady3 ?? '',
        'FEEDBACK_MOVE_PHONE_AWAY': feedbackMovePhoneAway ?? '',
        'FEEDBACK_MOVE_PHONE_CLOSER': feedbackMovePhoneCloser ?? '',
        'FEEDBACK_MOVE_PHONE_TO_EYE_LEVEL': feedbackMovePhoneToEyeLevel ?? '',
        'FEEDBACK_USE_EVEN_LIGHTING': feedbackUseEvenLighting ?? '',
        'FEEDBACK_FRAME_YOUR_FACE': feedbackFrameYourFace ?? '',
        'FEEDBACK_POSITION_FACE_STRAIGHT_IN_OVAL':
            feedbackPositionFaceStraightInOval ?? '',
        'FEEDBACK_REMOVE_DARK_GLASSES': feedbackRemoveDarkGlasses ?? '',
        'FEEDBACK_NEUTRAL_EXPRESSION': feedbackNeutralExpression ?? '',
        'FEEDBACK_CONDITIONS_TOO_BRIGHT': feedbackConditionsTooBright ?? '',
        'FEEDBACK_BRIGHTEN_YOUR_ENVIRONMENT':
            feedbackBrightenYourEnvironment ?? '',
      };
}
