//
//  AVChecker.swift
//  oiti_liveness3d
//
//  Created by Vitor Souza on 17/07/23.
//

import AVFoundation

enum AVChecker {
    static func checkCameraPermission() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    static func requestCameraAccess(result: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: result)
    }
}
