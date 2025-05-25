//
//  Toast.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

import SwiftUI


struct Toast: Hashable {
    let message: String
    let type: ToastType
    
    var color: Color {
        switch type {
        case .success:
            return Color.green
        case .error:
            return Color.red
        case .message:
            return Color.blue
        }
    }
}
