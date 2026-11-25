//
//  JapaMalaApp.swift
//  JapaMala
//
//  Created by Akash Belekar on 20/11/26.
//

import SwiftUI
import SwiftData

// MARK: - Application Entry Point

@main
struct JapaMalaApp: App {

    @State private var showHome = false

    var body: some Scene {

        WindowGroup {

            Group {

                if showHome {

                    RootView()

                } else {

                    SplashView {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showHome = true
                        }
                    }
                }
            }
            .modelContainer(
                for: [
                    JapaSession.self
                ]
            )
        }
    }
}


