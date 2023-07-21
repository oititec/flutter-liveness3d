import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/common/texts_builder.dart';
import 'package:oiti_liveness3d/common/loading_appearance.dart';
import 'package:oiti_liveness3d/common/liveness_success_result.dart';
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
  late TextEditingController _controller;
  var appKey = '';
  final environment = Environment.hml;
  final acitivityLoading = LoadingAppearence(
    type: LoadingType.activity,
    size: 2,
    backgroundColor: "#FFFFFF",
    loadingColor: "#000000",
  );
  final spinnerLoading = LoadingAppearence(
    type: LoadingType.spinner,
    size: 7,
    backgroundColor: "#000000",
    loadingColor: "#FFFFFF",
  );
  var resultTitle = '';
  var resultContent = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              _liveness3DWidgetOption(
                context,
                'Default',
              ),
              _liveness3DWidgetOption(
                context,
                'Spinner Loading',
                loading: spinnerLoading,
              ),
              _liveness3DWidgetOption(
                context,
                'Activity Loading',
                loading: acitivityLoading,
              ),
              _liveness3DWidgetOption(
                context,
                'Custom Texts',
                builder: _textsCustomization(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(resultContent),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child:
                    Text(appKey.isEmpty ? 'AppKey vazia' : 'AppKey disponivel'),
              ),
              appKeySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _liveness3DWidgetOption(
    BuildContext context,
    String title, {
    TextsBuilder? builder,
    LoadingAppearence? loading,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OitiLiveness3d.createLiveness3DWidget(
              appKey: appKey,
              environment: environment,
              textsBuilder: builder,
              loadingAppearance: loading,
              onSuccess: (result) => _onLiveness3DSuccess(result),
              onError: (error) => _onLiveness3DError(error),
            ),
          ),
        ).whenComplete(
          () => _showAlertDialog(
            context,
            resultTitle,
            resultContent,
          ),
        ),
        child: Text(title),
      ),
    );
  }

  Widget appKeySection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 45),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'App Key',
        ),
        obscureText: false,
        controller: _controller,
        onSubmitted: (value) => _pasteAppKey(),
      ),
    );
  }

  _pasteAppKey() {
    setState(() => appKey = _controller.text);
    _controller.text = '';
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

  Future<void> _showAlertDialog(
      BuildContext context, String resultType, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado: $resultType'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  /// Liveness 3D Callbacks
  _onLiveness3DSuccess(LivenessSuccessResult result) {
    resultTitle = 'Sucesso';
    resultContent =
        'Valid: ${result.valid}\nCodID: ${result.codId}\nCause: ${result.cause}\nProtocol: ${result.protocol}\nScan Result Blob: ${result.scanResultBlob}\n';
  }

  _onLiveness3DError(Object? error) {
    resultTitle = 'Error';
    resultContent = 'Cause: ${error.toString()}';
  }
}
