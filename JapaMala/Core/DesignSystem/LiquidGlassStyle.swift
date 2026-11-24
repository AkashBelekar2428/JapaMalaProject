//
//  LiquidGlassStyle.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//

import SwiftUI

extension View {

    @ViewBuilder
    func malaGlass<S: Shape>(in shape: S) -> some View {

        if #available(iOS 26.0, *) {

            self.glassEffect(
                .regular,
                in: shape
            )

        } else {

            self.background(
                .ultraThinMaterial,
                in: shape
            )
        }
    }
}
