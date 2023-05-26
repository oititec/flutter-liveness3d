import Flutter
import UIKit
import FaceCaptcha

public class OitiLiveness3dPlugin: NSObject, FlutterPlugin, Liveness3DDelegate {
   
    private var result: FlutterResult?;
    
    public func handleLiveness3DCanceled() {
        self.result?(FlutterError(code: "USER_CANCELLED", message: "USER_CANCELLED", details: nil))
    }
    
    public func handleLiveness3DValidation(validateModel: FaceCaptcha.Liveness3DSuccess) {
        var response:Dictionary<String,Any> = Dictionary();
        response["cause"] = validateModel.cause ?? "";
        response["codId"] = validateModel.codID ?? 0;
        response["protocolo"] = validateModel.protocolo ?? "";
        response["scanResultBlob"] = validateModel.scanResultBlob ?? "";
        response["valid"] = validateModel.valid ?? false;
        self.result?(response)
    }

    public func handleLiveness3DError(error: FaceCaptcha.Liveness3DError) {
        let errorCode: String = error.errorCode == Liveness3DErrorCode.LIVENESS_NOT_COMPLETED ? "LIVENESS_NOT_COMPLETED" : error.errorCode.rawValue
        self.result?(FlutterError(code: errorCode, message: error.errorMessage, details: nil))
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "oiti_liveness3d", binaryMessenger: registrar.messenger())
        let instance = OitiLiveness3dPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.result = result;
        
        switch call.method {
        case "OITI.startLiveness3d":
            if let args = call.arguments as? Dictionary<String,Any> {
                liveness3d(args: args)
            } else {
                var error:Dictionary<String,Any> = Dictionary();
                error["message"] =
                "Something went wrong. Check Plugin Interface";
                result(error)
            }
        case "OITI.eventLog":
            if let args = call.arguments as? Dictionary<String,Any> {
                eventLog(args: args)
            } else {
                var error:Dictionary<String,Any> = Dictionary();
                error["message"] =
                "Something went wrong. Check Plugin Interface";
                result(error)
            }
            
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
    
    private func liveness3d(args:Dictionary<String,Any>?) {
        let appKey = args?["appKey"] as? String
        let baseUrl = args?["baseUrl"] as? String
        let isProd = args?["isProd"] as? Bool
        let baseUrlWithoutPath = "https://" + (baseUrl?.components(separatedBy: "/")[2] ?? "")
        let env: Environment3D = isProd == true ? Environment3D.PRD : Environment3D.HML
        
        let liveness3DViewController = Liveness3DViewController(
            endpoint: baseUrlWithoutPath,
            liveness3DUser: Liveness3DUser(appKey: appKey!, environment: env),
            debugOn: false
        )
        
        liveness3DViewController.delegate = self
        liveness3DViewController.modalPresentationStyle = .fullScreen
        UIApplication.shared.keyWindow?.rootViewController?.present(liveness3DViewController, animated: true, completion: nil)
        
    }
    private func eventLog(args:Dictionary<String,Any>?) {
        let event = args?["event"] as? String
        print(event)
        
    }
}
