//
//  LoadingType.swift
//  oiti_liveness3d
//
//  Created by Vitor Souza on 17/07/23.
//

import Foundation

enum LoadingType: String {
    case activity
    case spinner
    
    static func type(from typeString: String) -> LoadingType {
        return LoadingType(rawValue: typeString) ?? .activity
    }
}
