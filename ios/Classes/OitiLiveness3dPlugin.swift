//
//  OitiLiveness3dPlugin.swift
//  oiti_liveness3d
//

import UIKit
import Flutter
import OILiveness3D
import OIComponents

public class OitiLiveness3dPlugin: NSObject, FlutterPlugin {
    var result: FlutterResult?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "oiti_liveness3d", binaryMessenger: registrar.messenger())
        let instance = OitiLiveness3dPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.result = result
        let callArguments = call.arguments
        
        do {
            switch call.method {
            case "OITI.startLiveness3d":
                try startLiveness3D(arguments: callArguments)
            case "OITI.checkPermission":
                result(AVChecker.checkCameraPermission())
            case "OITI.askPermission":
                AVChecker.requestCameraAccess(result: { result($0) })
            case "OITI.eventLog":
                try eventLog(arguments: callArguments)
            case "OITI.openSettingsApp":
                openSettingsApp()
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
        } catch PluginError.noCameraPermission {
            finishChannel(error: .noCameraPermission, result: result)
        } catch {
            let error = ["message": "Something went wrong. Check Plugin Interface"]
            result(error)
        }
    }
    
    private func startLiveness3D(arguments rawArguments: Any?) throws {
        guard let arguments = rawArguments as? Dictionary<String, Any> else {
            throw PluginError.invalidArguments
        }
        
        guard AVChecker.checkCameraPermission() else {
            throw PluginError.noCameraPermission
        }
        
        let appKey = arguments["appkey"] as? String ?? ""
        let rawEnvironment = arguments["environment"] as? String ?? ""
        let environment = Environment(rawValue: rawEnvironment) ?? .HML
        
        let loading = arguments["loading"] as? Dictionary<String, Any>
        let loadingType = LoadingType.type(from: loading?["type"] as? String ?? "")
        let loadingSize = loading?["size"] as? Int ?? 1
        let loadingBackgroundColor = loading?["background"] as? String ?? "#FFFFFF"
        let loadingColor = loading?["foreground"] as? String ?? "#05D758"
        
        let loadingConfiguration: LoadingViewConfigurationProtocol = {
            switch loadingType {
            case .activity:
                return ActivityIndicatorConfiguration(
                    loadingColor: .init(hex: loadingColor),
                    backgroundColor: .init(hex: loadingBackgroundColor),
                    scaleFactor: loadingSize
                )
            case .spinner:
                return SpinnerConfiguration(
                    backgroundColor: .init(hex: loadingBackgroundColor),
                    loadingColor: .init(hex: loadingColor),
                    strokeWidth: 10,
                    scaleFactor: loadingSize
                )
            }
        }()
        
        let texts = liveness3DTexts(from: arguments["texts"])
        let user = Liveness3DUser(
            appKey: appKey,
            environment: environment,
            texts: texts
        )
        
        let viewController = HybridLiveness3DViewController(
            liveness3DUser: user,
            delegate: self,
            customAppearance: .init(configuration: loadingConfiguration)
        )
        
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func eventLog(arguments rawArguments: Any?) throws {
        guard let arguments = rawArguments as? Dictionary<String, Any> else {
            throw PluginError.invalidArguments
        }
        
        let event = (arguments["event"] as? String) ?? ""
        print(event)
    }
    
    func openSettingsApp() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
