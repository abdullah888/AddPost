//
//  Styles.swift
//  ZZapp
//
//  Created by abdullah on 01/09/1443 AH.
//

import SwiftUI

struct StrokeStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .stroke(.linearGradient(colors: [.white.opacity(0.3), .black.opacity(0.1)], startPoint: .top, endPoint: .bottom))
            .blendMode(.overlay))
    }
}


extension View {
    func strokeStyle() -> some View {
        modifier(StrokeStyle())
    }
}
