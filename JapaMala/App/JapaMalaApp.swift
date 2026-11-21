//
//  JapaMalaApp.swift
//  JapaMala
//
//  Created by Akash Belekar on 20/11/26.
//
import SwiftUI

//MARK: Application entry point

@main
struct JapaMalaApp: App {

    @State private var showHome = false

    var body: some Scene {

        WindowGroup {

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
    }
}

