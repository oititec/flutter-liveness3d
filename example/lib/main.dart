import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/common/texts_builder.dart';
import 'package:oiti_liveness3d/common/loading_appearance.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _oitiLiveness3DPlugin = OitiLiveness3d();
  final appKey = 'APP_KEY';
  final environment = Environment.hml;
  final acitivityLoading = LoadingAppearence(
      type: LoadingType.activity,
      size: 2,
      backgroundColor: "#FFFFFF",
      loadingColor: "#000000");
  final spinnerLoading = LoadingAppearence(
      type: LoadingType.spinner,
      size: 7,
      backgroundColor: "#000000",
      loadingColor: "#FFFFFF");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Liveness 3D - Flutter'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => _pushLiveness3DWidget(context),
                  child: const Text("Default")),
              ElevatedButton(
                  onPressed: () =>
                      _pushLiveness3DWidget(context, loading: spinnerLoading),
                  child: const Text("Spinner Loading")),
              ElevatedButton(
                  onPressed: () =>
                      _pushLiveness3DWidget(context, loading: acitivityLoading),
                  child: const Text("Activity Loading")),
              ElevatedButton(
                  onPressed: () {
                    final builder = _textsCustomization();
                    _pushLiveness3DWidget(context, builder: builder);
                  },
                  child: const Text("Custom Texts")),
            ],
          ),
        ),
      ),
    );
  }

  _pushLiveness3DWidget(BuildContext context,
      {TextsBuilder? builder, LoadingAppearence? loading}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => _oitiLiveness3DPlugin.createLiveness3DWidget(
                appKey: appKey,
                environment: environment,
                textsBuilder: builder,
                loadingAppearance: loading)));
  }

  TextsBuilder _textsCustomization() {
    return TextsBuilder()
      ..readyHeader1 = 'ready_header_1'
      ..readyHeader2 = 'ready_header_2'
      ..readyMessage1 = 'ready_message_1'
      ..readyMessage2 = 'ready_message_2'
      ..readyButton = 'ready_button'
      ..retryHeader = 'retry_header'
      ..retrySubheader = 'retry_subheader'
      ..retryYourPicture = 'retry_your_picture'
      ..retryIdealPicture = 'retry_ideal_picture'
      ..retryMessageSmile = 'retry_message_smile'
      ..retryMessageLighting = 'retry_message_lighting'
      ..retryMessageContrast = 'retry_message_contrast'
      ..retryButton = 'retry_button'
      ..resultUploadMessage = 'retry_upload_message'
      ..resultSuccessMessage = 'result_success_message'
      ..feedbackCenterFace = 'feedback_center_face'
      ..feedbackFaceNotFound = 'feedback_face_not_found'
      ..feedbackFaceNotLookingStraightAhead =
          'feedback_face_not_looking_straight_ahead'
      ..feedbackFaceNotUpright = 'feedback_face_not_upright'
      ..feedbackHoldSteady = 'feedback_hold_steady'
      ..feedbackMovePhoneAway = 'feedback_move_phone_away'
      ..feedbackMovePhoneCloser = 'feedback_move_phone_closer'
      ..feedbackMovePhoneToEyeLevel = 'feedback_move_phone_to_eye_level'
      ..feedbackUseEvenLighting = 'feedback_use_even_lighting'
      ..feedbackFrameYourFace = 'feedback_frame_your_face'
      ..feedbackPositionFaceStraightInOval =
          'feedback_position_face_straight_in_oval'
      ..feedbackHoldSteady1 = 'feedback_hold_steady_1'
      ..feedbackHoldSteady2 = 'feedback_hold_steady_2'
      ..feedbackHoldSteady3 = 'feedback_hold_steady_3'
      ..feedbackRemoveDarkGlasses = 'feedback_remove_dark_glasses'
      ..feedbackNeutralExpression = 'feedback_neutral_expression'
      ..feedbackConditionsTooBright = 'feedback_conditions_too_bright'
      ..feedbackBrightenYourEnvironment = 'feedback_brighten_your_environment';
  }
}
