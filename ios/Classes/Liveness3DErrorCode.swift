//
//  Liveness3DErrorCode.swift
//  oiti_liveness3d
//
//  Created by Filipe Marques on 04/07/23.
//

import Foundation

public enum Liveness3DErrorCode: Int, Error {
    // App Key inválido.
    case invalidAppKey = 0
    // Não foi concedida permissão de acesso à câmera do aparelho.
    case noCameraPermission = 1
    // Sem conexão à Internet.
    case noInternetConnection = 2
    // Prova de vida não foi completada.
    case livenessNotCompleted = 3
    // Liveness não foi inicializado corretamente.
    case livenessNotInitialized = 4

    var code: Int { rawValue }

    var message: String {

        switch self {

        case .invalidAppKey: return "App Key inválido."

        case .noCameraPermission: return "Não foi concedida permissão de acesso à câmera do aparelho."

        case .noInternetConnection: return "Sem conexão à Internet."

        case .livenessNotCompleted: return "Prova de vida não foi completada."

        case .livenessNotInitialized: return "Liveness não foi inicializado corretamente."

        }

    }

}
