//
//  ContentView.swift
//  JapaMala
//
//  Created by Akash Belekar on 20/11/26.
//


import SwiftUI

struct HomeView: View {
    
    // Parent view provides navigation action
    var onBeginPractice: () -> Void
    
    var body: some View {
        
        ZStack {
            
            AppColors.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Come back to yourself.")
                    .font(.largeTitle)
                    .foregroundStyle(AppColors.primaryText)
                
                Text("A slower start. A softer day.")
                    .foregroundStyle(AppColors.secondaryText)
                
                Button {
                    
                    onBeginPractice()
                    
                } label: {
                    
                    HStack {
                        
                        Text("Begin practice")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                    .foregroundStyle(AppColors.buttonText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.buttonBackground)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24)
                    )
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView {
        print("Navigate to Chant")
    }
}
