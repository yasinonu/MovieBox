//
//  ToastExtension.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

import Foundation
import SwiftUI

extension View {
    func toast(_ toastBinding: Binding<Toast?>) -> some View {
        self.overlay(alignment: .top) {
            ZStack {
                if let toast = toastBinding.wrappedValue {
                    Text(toast.message)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(toast.color)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.4), radius: 6, x: 3, y: 3)
                        .padding(.horizontal)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                        .task {
                            try? await Task.sleep(for: .seconds(1.5))
                            toastBinding.wrappedValue = nil
                            try? await Task.sleep(for: .seconds(0.1))
                            toastBinding.wrappedValue = nil
                        }
                }
            }
            .animation(.easeInOut, value: toastBinding.wrappedValue)
        }
    }
}
