//
//  sl.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//

import SwiftUI
import Lottie

// MARK: - Launch Screen
struct SplashView: View {
    
    //Closure
    var onFinished: () -> Void
    
    var body: some View {
        
        ZStack {
            // MARK: - Background
            AppColors.background
                .ignoresSafeArea()
            
            // MARK: - Lottie Animation
            LottieView(
                animation: .named("mala_splash")
            )
            .playing(
                .fromProgress(
                    0,toProgress: 1,loopMode: .playOnce
                )
            )
            .animationDidFinish { completed in
                
                if completed {
                    
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.5
                    ) {
                        onFinished()
                    }
                }
            }
            .configure { animationView in
                animationView.contentMode = .scaleAspectFill
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
        }
        .ignoresSafeArea()
    }
}
