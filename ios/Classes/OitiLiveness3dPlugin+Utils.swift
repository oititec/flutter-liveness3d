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
    
    func finishChannel(error: Liveness3DError, result: @escaping FlutterResult) {
        let flutterError = FlutterError(
            code: String(error.code),
            message: error.message,
            details: nil
        )
        result(flutterError)
    }
    
    func finishChannel(error code: Liveness3DErrorCode, result: @escaping FlutterResult) {
        let flutterError = FlutterError(
            code: String(code.code),
            message: code.message,
            details: nil
        )
        result(flutterError)
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
    
    func liveness3DTexts(from arguments: Any?) -> [Liveness3DTextKey : String] {
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
}
