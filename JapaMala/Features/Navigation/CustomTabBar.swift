//
//  CustomTabBar.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//

import SwiftUI
//Home · Chant · Mantras · History
//MARK: Controls the tab bar UI and animation.
struct CustomTabBar: View {
    
    //@Binding:  Shares state between views
    @Binding var selectedTab: AppTab
    
    //@Namespace: Coordinates matched animations
    @Namespace private var animation
    
    // matchedGeometryEffect    Animates the selected background
    
    var body: some View {
        
        HStack(spacing: 8) {
            
            ForEach(AppTab.allCases) { tab in
                
                let isSelected = selectedTab == tab
                
                Button {
                    
                    selectTab(tab)
                    
                } label: {
                    
                    VStack(spacing: 8) {
                        
                        // Tab Icon
                        Image(tab.symbol)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                        
                        // Tab Title
                        Text(tab.title)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundStyle(
                        isSelected
                        ? AppColors.primary
                        : AppColors.tabBarIconColor
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background {
                        
                        if isSelected {
                            
                            RoundedRectangle(cornerRadius: 26)
                                .fill(.clear)
                                .glassEffect(
                                    .regular.tint(
                                        AppColors.selectedTabBackgroundColor
                                    ),
                                    in: RoundedRectangle(
                                        cornerRadius: 26
                                    )
                                )
                                .matchedGeometryEffect(
                                    id: "TAB_BACKGROUND",
                                    in: animation
                                )
                        }
                    }
                    .malaGlass(
                        in: RoundedRectangle(cornerRadius: 24)
                    )
            
                }
                .buttonStyle(.plain)
                .accessibilityLabel(tab.title)
                .accessibilityAddTraits(
                    isSelected ? .isSelected : []
                )
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 10)
        .padding(.bottom, 8)
        
        // Outer Liquid Glass Background
        .background {
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay {
                    Capsule()
                        .strokeBorder(
                            AppColors.border.opacity(0.5),
                            lineWidth: 1
                        )
                }
                .ignoresSafeArea(edges: .bottom)
        }
        
        .padding(.horizontal, 12)
        .padding(.bottom, 10)
        
        // Swipe ONLY on the tab bar
        .simultaneousGesture(
            DragGesture(minimumDistance: 25)
                .onEnded { value in
                    
                    let horizontal = value.translation.width
                    let vertical = value.translation.height
                    
                    // Recognize horizontal swipes only
                    guard abs(horizontal) > abs(vertical) * 1.5 else {
                        return
                    }
                    
                    if horizontal < -40 {
                        moveTab(direction: 1)
                    } else if horizontal > 40 {
                        moveTab(direction: -1)
                    }
                }
        )
    }
    
    // MARK: - Select Tab
    
    private func selectTab(_ tab: AppTab) {
        
        withAnimation(
            .spring(response: 0.45, dampingFraction: 0.78)
        ) {
            selectedTab = tab
        }
    }
    
    // MARK: - Swipe Navigation
    
    private func moveTab(direction: Int) {
        
        let tabs = AppTab.allCases
        
        guard let currentIndex = tabs.firstIndex(of: selectedTab) else {
            return
        }
        
        let newIndex = currentIndex + direction
        
        guard tabs.indices.contains(newIndex) else {
            return
        }
        
        withAnimation(
            .spring(response: 0.45, dampingFraction: 0.78)
        ) {
            selectedTab = tabs[newIndex]
        }
    }
}

