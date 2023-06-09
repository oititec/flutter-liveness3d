import Flutter
import UIKit
import OILiveness3D
import OIComponents
import AVFoundation

public class OitiLiveness3dPlugin: NSObject, FlutterPlugin, Liveness3DDelegate {
    
    private var result: FlutterResult?;
    
    public func handleLiveness3DCanceled() {
        self.result?(FlutterError(code: "USER_CANCELLED", message: "USER_CANCELLED", details: nil))
    }
    
    public func handleLiveness3DValidation(validateModel: Liveness3DSuccess) {
        var response:Dictionary<String,Any> = Dictionary();
        response["cause"] = validateModel.cause ?? "";
        response["codId"] = validateModel.codID ?? 0;
        response["protocolo"] = validateModel.protocolo ?? "";
        response["scanResultBlob"] = validateModel.scanResultBlob ?? "";
        response["valid"] = validateModel.valid ?? false;
        self.result?(response)
    }
    
    public func handleLiveness3DError(error: Liveness3DError) {
        self.result?(FlutterError(code: String(error.code), message: error.message, details: nil))
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
        case "OITI.checkPermission":
            checkpermissiongranted()
        case "OITI.askPermission":
            askpermission()
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
    
    private func checkpermissiongranted(){
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            self.result?(true)
        } else {
            self.result?(false)
        }
    }
    
    private func askpermission(){
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                self.result?(true)
                
            } else {
                self.result?(false)
            }
        }
    }
    
    private func liveness3d(args:Dictionary<String,Any>?) {
        
        let appKey = args?["appKey"] as? String
        let baseUrl = args?["baseUrl"] as? String
        let loading = args?["loading"] as? Dictionary<String,Any> ?? nil
        let isProd = args?["isProd"] as? Bool
        let env: Environment = isProd == true ? Environment.PRD: Environment.HML
      
        let typeLoading = loading?["type"] as? String ?? "default"
        let sizeLoading = loading?["size"] as? CGFloat ?? 1
        let backgroundColor = loading?["backgroundColor"] as? String ?? "#FFFFFF"
        let loadingColor = loading?["loadingColor"] as? String ?? "#000000"
        
       
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            
            
            
            if(typeLoading == "spinner"){
                let LoadingConfig = SpinnerConfiguration(
                    backgroundColor: .init(hex: backgroundColor),
                    loadingColor: .init(hex: loadingColor),
                    strokeWidth: 10,
                    scaleFactor: sizeLoading
                )
                
                let liveness3DViewController = HybridLiveness3DViewController(
                    liveness3DUser: Liveness3DUser(appKey: appKey!, environment: env),
                    delegate: self,
                    customAppearance: .init(configuration: LoadingConfig)
                )
                liveness3DViewController.modalPresentationStyle = .fullScreen
                UIApplication.shared.keyWindow?.rootViewController?.present(liveness3DViewController, animated: true, completion: nil)
            }else {
                let LoadingConfig = ActivityIndicatorConfiguration(
                    loadingColor: .init(hex: loadingColor),
                    backgroundColor: .init(hex: backgroundColor)
                  //  scaleFactor: sizeLoading
                )
                
                let liveness3DViewController = HybridLiveness3DViewController(
                    liveness3DUser: Liveness3DUser(appKey: appKey!, environment: env),
                    delegate: self,
                    customAppearance: .init(configuration: LoadingConfig)
                )
                liveness3DViewController.modalPresentationStyle = .fullScreen
                UIApplication.shared.keyWindow?.rootViewController?.present(liveness3DViewController, animated: true, completion: nil)
            }
            
            
        }
        
    }
    private func eventLog(args:Dictionary<String,Any>?) {
        let event = args?["event"] as? String
        print(event as Any)
        
    }
}


public extension UIColor {
    
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
