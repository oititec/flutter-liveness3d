//
//  OitiLiveness3dPlugin+Utils.swift
//  oiti_liveness3d
//
//  Created by Vitor Souza on 17/07/23.
//

import UIKit
import Flutter
import OILiveness3D

extension OitiLiveness3dPlugin {
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        UIApplication.shared.keyWindow?.rootViewController?
            .present(viewController, animated: animated, completion: completion)
    }

    func finishChannel(error: Liveness3DError, result: FlutterResult?) {
        let flutterError = FlutterError(
            code: String(error.code),
            message: error.message,
            details: nil
        )
        result?(flutterError)
    }

    func finishChannel(error code: Liveness3DErrorCode, result: FlutterResult?) {
        let flutterError = FlutterError(
            code: String(code.code),
            message: code.message,
            details: nil
        )
        result?(flutterError)
    }

    func textKey(from identifier: String) -> Liveness3DTextKey? {
        switch identifier {
        case "READY_HEADER_1": return .readyHeader1
        case "READY_HEADER_2": return .readyHeader2
        case "READY_MESSAGE_1": return .readyMessage1
        case "READY_MESSAGE_2": return .readyMessage2
        case "READY_BUTTON": return .readyButton
        case "RETRY_HEADER": return .retryHeader
        case "RETRY_SUBHEADER": return .retrySubheader
        case "RETRY_YOUR_PICTURE": return .retryYourPicture
        case "RETRY_IDEAL_PICTURE": return .retryIdealPicture
        case "RETRY_MESSAGE_SMILE": return .retryMessageSmile
        case "RETRY_MESSAGE_LIGHTING": return .retryMessageLightning
        case "RETRY_MESSAGE_CONTRAST": return .retryMessageContrast
        case "RETRY_BUTTON": return .retryButton
        case "RESULT_UPLOAD_MESSAGE": return .resultUploadMessage
        case "RESULT_SUCCESS_MESSAGE": return .resultSuccessMessage
        case "FEEDBACK_CENTER_FACE": return .feedbackCenterFace
        case "FEEDBACK_FACE_NOT_FOUND": return .feedbackFaceNotFound
        case "FEEDBACK_FACE_NOT_LOOKING_STRAIGHT_AHEAD": return .feedbackFaceNotLookingStraightAhead
        case "FEEDBACK_FACE_NOT_UPRIGHT": return .feedbackFaceNotUpright
        case "FEEDBACK_HOLD_STEADY": return .feedbackHoldSteady
        case "FEEDBACK_HOLD_STEADY_1": return .feedbackHoldSteady1
        case "FEEDBACK_HOLD_STEADY_2": return .feedbackHoldSteady2
        case "FEEDBACK_HOLD_STEADY_3": return .feedbackHoldSteady3
        case "FEEDBACK_MOVE_PHONE_AWAY": return .feedbackMovePhoneAway
        case "FEEDBACK_MOVE_PHONE_CLOSER": return .feedbackMovePhoneCloser
        case "FEEDBACK_MOVE_PHONE_TO_EYE_LEVEL": return .feedbackMovePhoneToEyeLevel
        case "FEEDBACK_USE_EVEN_LIGHTING": return .feedbackUseEvenLighting
        case "FEEDBACK_FRAME_YOUR_FACE": return .feedbackFrameYourFace
        case "FEEDBACK_POSITION_FACE_STRAIGHT_IN_OVAL": return .feedbackPositionFaceStraightInOval
        case "FEEDBACK_REMOVE_DARK_GLASSES": return .feedbackRemoveDarkGlasses
        case "FEEDBACK_NEUTRAL_EXPRESSION": return .feedbackNeutralExpression
        case "FEEDBACK_CONDITIONS_TOO_BRIGHT": return .feedbackConditionsTooBright
        case "FEEDBACK_BRIGHTEN_YOUR_ENVIRONMENT": return .feedbackBrightenYourEnvironment
        default: return nil
        }
    }

    func getLiveness3dTexts(from arguments: Any?) -> [Liveness3DTextKey : String] {
        guard let textsDictionary = arguments as? Dictionary<String, String> else {
            return [:]
        }

        let sequence: [(Liveness3DTextKey, String)] = textsDictionary
            .compactMap {
                guard let key = self.textKey(from: $0.key) else {
                    return nil
                }
                return (key, $0.value)
            }
            .filter { !$0.1.isEmpty }

        return Dictionary(uniqueKeysWithValues: sequence)
    }

    func getLiveness3dTheme(from arguments: Dictionary<String, Any>) -> Liveness3DTheme {
        var theme = Liveness3DTheme(.light)
        theme = customizeFonts(in: theme, with: arguments)
        theme = customizeContent(in: theme, with: arguments)
        return theme
    }

    private func customizeFonts(
        in rawTheme: Liveness3DTheme,
        with arguments: Dictionary<String, Any>
    ) -> Liveness3DTheme {
        var theme = rawTheme
        let fontsDictionary = arguments["fonts"] as? Dictionary<String, Any>
        print(fontsDictionary as Any)

        /* Guidance */
        theme.guidanceCustomizationHeaderFont = getFont(from: fontsDictionary?["guidanceCustomizationHeaderFont"])
        theme.guidanceCustomizationSubtextFont = getFont(from: fontsDictionary?["guidanceCustomizationSubtextFont"])

        /* Button */
        theme.guidanceCustomizationButtonFont = getFont(from: fontsDictionary?["guidanceCustomizationButtonFont"])

        /* Ready Screen */
        theme.readyScreenCustomizationSubtextFont = getFont(from: fontsDictionary?["readyScreenCustomizationHeaderFont"])
        theme.readyScreenCustomizationHeaderFont = getFont(from: fontsDictionary?["readyScreenCustomizationSubtextFont"])

        /* Retry Screen */
        theme.retryScreenCustomizationHeaderFont = getFont(from: fontsDictionary?["retryScreenCustomizationHeaderFont"])
        theme.retryScreenCustomizationSubtextFont = getFont(from: fontsDictionary?["retryScreenCustomizationSubtextFont"])

        /* Result Screen */
        theme.resultScreenCustomizationMessageFont = getFont(from: fontsDictionary?["resultScreenCustomizationMessageFont"])

        /* Feedback */
        theme.feedbackCustomizationTextFont = getFont(from: fontsDictionary?["feedbackCustomizationTextFont"])

        return theme
    }

    private func customizeContent(
        in rawTheme: Liveness3DTheme,
        with arguments: Dictionary<String, Any>
    ) -> Liveness3DTheme {
        var theme = rawTheme
        let themeDictionary = arguments["theme"] as? Dictionary<String, Any>

        /* Button */
        theme.guidanceCustomizationButtonTextNormalColor = .init(hex: themeDictionary?["guidanceCustomizationButtonTextNormalColor"] as? String ?? "#000000")
        theme.guidanceCustomizationButtonBackgroundNormalColor = .init(hex: themeDictionary?["guidanceCustomizationButtonBackgroundNormalColor"] as? String ?? "#05D758")
        theme.guidanceCustomizationButtonTextHighlightColor = .init(hex: themeDictionary?["guidanceCustomizationButtonTextHighlightColor"] as? String ?? "#FFFFFF")
        theme.guidanceCustomizationButtonBackgroundHighlightColor = .init(hex: themeDictionary?["guidanceCustomizationButtonBackgroundHighlightColor"] as? String ?? "#05D758")
        theme.guidanceCustomizationButtonTextDisabledColor = .init(hex: themeDictionary?["guidanceCustomizationButtonTextDisabledColor"] as? String ?? "#A3A3A3")
        theme.guidanceCustomizationButtonBackgroundDisabledColor = .init(hex: themeDictionary?["guidanceCustomizationButtonBackgroundDisabledColor"] as? String ?? "#F5F5F5")
        theme.guidanceCustomizationButtonBorderColor = .init(hex: themeDictionary?["guidanceCustomizationButtonBorderColor"] as? String ?? "#000000")
        theme.guidanceCustomizationButtonBorderWidth = themeDictionary?["guidanceCustomizationButtonBorderWidth"] as? Int32 ?? 0
        theme.guidanceCustomizationButtonCornerRadius = themeDictionary?["guidanceCustomizationButtonCornerRadius"] as? Int32 ?? 10

        /* Ready Screen */
        theme.readyScreenCustomizationHeaderTextColor = .init(hex: themeDictionary?["guidanceCustomizationReadyScreenHeaderTextColor"] as? String ?? "#000000")
        theme.readyScreenCustomizationSubtextTextColor = .init(hex: themeDictionary?["guidanceCustomizationReadyScreenSubtextTextColor"] as? String ?? "#666666")
        // theme.readyScreenCustomizationTextBackgroundColor = .init(hex: themeDictionary?["guidanceCustomizationTextBackgroundColor"] as? String ?? "")
        // theme.readyScreenCustomizationTextBackgroundCornerRadius = themeDictionary?["guidanceCustomizationTextBackgroundColorRadius"] as? Int32 ?? 0

        /* Retry Screen */
        theme.retryScreenCustomizationHeaderTextColor = .init(hex: themeDictionary?["guidanceCustomizationRetryScreenHeaderTextColor"] as? String ?? "#000000")
        theme.retryScreenCustomizationSubtextTextColor = .init(hex: themeDictionary?["guidanceCustomizationRetryScreenSubtextTextColor"] as? String ?? "#666666")
        theme.retryScreenCustomizationImageBorderColor = .init(hex: themeDictionary?["guidanceCustomizationRetryScreenImageBorderColor"] as? String ?? "#05D758")
        theme.retryScreenCustomizationImageBorderWidth = themeDictionary?["guidanceCustomizationRetryScreenImageBorderWidth"] as? Int32 ?? 0
        theme.retryScreenCustomizationImageCornerRadius = themeDictionary?["guidanceCustomizationRetryScreenImageCornerRadius"] as? Int32 ?? 16

        /* Result Screen */
        theme.resultScreenCustomizationUploadProgressFillColor = .init(hex: themeDictionary?["resultScreenCustomizationUploadProgressFillColor"] as? String ?? "#05D758")
        theme.resultScreenCustomizationUploadProgressTrackColor = .init(hex: themeDictionary?["resultScreenCustomizationUploadProgressTrackColor"] as? String ?? "#E0E0E0")
        theme.resultScreenCustomizationTextColor = .init(hex: themeDictionary?["resultScreenCustomizationForegroundColor"] as? String ?? "#09244F")
         theme.resultScreenCustomizationAnimationStyle = .blob(appearance: BlobAnimationAppearance(
             blobColor: .init(hex: themeDictionary?["resultScreenCustomizationActivityIndicatorColor"] as? String ?? "#05D758"),
             checkmarkForegroundColor: .init(hex: themeDictionary?["resultScreenCustomizationResultAnimationForegroundColor"] as? String ?? "#FFFFFF"),
             checkmarkBackgroundColor: .init(hex: themeDictionary?["resultScreenCustomizationResultAnimationBackgroundColor"] as? String ?? "#05D758")
         ))
        // theme.resultScreenCustomizationAnimationRelativeScale = 1.5
        // theme.resultScreenCustomizationShowUploadProgressBar = true

        /* Oval */
        theme.ovalCustomizationStrokeWidth = themeDictionary?["ovalCustomizationStrokeWidth"] as? Int32 ?? 3
        theme.ovalCustomizationStrokeColor = .init(hex: themeDictionary?["ovalCustomizationStrokeColor"] as? String ?? "#05D758")
        theme.ovalCustomizationProgressStrokeWidth = themeDictionary?["ovalCustomizationProgressStrokeWidth"] as? Int32 ?? 2
        theme.ovalCustomizationProgressColor1 = .init(hex: themeDictionary?["ovalCustomizationProgressColor1"] as? String ?? "#05D758")
        theme.ovalCustomizationProgressColor2 = .init(hex: themeDictionary?["ovalCustomizationProgressColor2"] as? String ?? "#05D758")
        theme.ovalCustomizationProgressRadialOffset = themeDictionary?["ovalCustomizationProgressRadialOffset"] as? Int32 ?? 2

        /* Frame */
        theme.frameCustomizationBorderWidth = themeDictionary?["frameCustomizationBorderWidth"] as? Int32 ?? 0
        theme.frameCustomizationCornerRadius = themeDictionary?["frameCustomizationCornerRadius"] as? Int32 ?? 0
        theme.frameCustomizationBorderColor = .init(hex: themeDictionary?["frameCustomizationBorderColor"] as? String ?? "#05D758")
        theme.frameCustomizationBackgroundColor = .init(hex: themeDictionary?["frameCustomizationBackgroundColor"] as? String ?? "#FFFFFF")
        // theme.frameCustomizationShadow = Liveness3DShadow(
        //     color: .red, opacity: 0.8,
        //     radius: 1.0, offset: .zero,
        //     insets: .init(top: 1.0, left: 0.5, bottom: 0.7, right: 0.5)
        // )

        /* Overlay */
        theme.overlayCustomizationBackgroundColor = .init(hex: themeDictionary?["overlayCustomizationBackgroundColor"] as? String ?? "#FFFFFF")
        // theme.overlayCustomizationBrandingImage = UIImage(named: "")
        // theme.overlayCustomizationShowBrandingImage = false

        /* Feedback */
        theme.feedbackCustomizationCornerRadius = themeDictionary?["feedbackCustomizationCornerRadius"] as? Int32 ?? 10
        theme.feedbackCustomizationBackgroundColor = .init(hex: themeDictionary?["feedbackCustomizationBackgroundColors"] as? String ?? "#000000")
        theme.feedbackCustomizationTextColor = .init(hex: themeDictionary?["feedbackCustomizationTextColor"] as? String ?? "#FFFFFF")
        // theme.feedbackCustomizationShadow = Liveness3DShadow(
        //     color: .purple, opacity: 0.5,
        //     radius: 3.0, offset: .init(width: 2.0, height: 5.0),
        //     insets: .init(top: 3.0, left: 1.5, bottom: 3.7, right: 7.5)
        // )

        /* Cancel button */
        // theme.cancelButtonCustomizationCustomImage = UIImage(named: "")
        // theme.cancelButtonCustomizationLocation = .topLeft

        return theme
    }

    private func getFont(from font: Any?) -> UIFont? {
        UIFont(name: (font as? String ?? ""), size: 14)
    }
}
