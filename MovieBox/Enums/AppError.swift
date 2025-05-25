//
//  AppError.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import SwiftUI

enum AppError: LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case networkError
    case decodingError
    case encodingError
    case unauthorized
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network connection failed."
        case .decodingError:
            return "Failed to parse server response."
        case .encodingError:
            return "Failed to encode request data."
        case .unauthorized:
            return "Session expired. Please login again."
        case .custom(let message):
            return message
        }
    }
}
