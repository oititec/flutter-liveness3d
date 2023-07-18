//
//  OitiLiveness3dPlugin+Liveness3DDelegate.swift
//  oiti_liveness3d
//
//  Created by Vitor Souza on 17/07/23.
//

import Foundation
import Flutter
import OILiveness3D

extension OitiLiveness3dPlugin: Liveness3DDelegate {
    public func handleLiveness3DValidation(validateModel: Liveness3DSuccess) {
        let response: Dictionary<String, Any> = [
            "cause": validateModel.cause ?? "",
            "codId": validateModel.codID ?? 0,
            "protocolo": validateModel.protocolo ?? "",
            "scanResultBlob": validateModel.scanResultBlob ?? "",
            "valid": validateModel.valid ?? false
        ]
        
        result?(response)
    }
    
    public func handleLiveness3DError(error: Liveness3DError) {
        finishChannel(error: error, result: result)
    }
}
