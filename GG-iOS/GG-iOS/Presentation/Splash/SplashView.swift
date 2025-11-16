//
//  SplashView.swift
//  GG-iOS
//
//  Created by 김승원 on 11/16/25.
//

import SwiftUI

struct SplashView: View {
    
    // MARK: - Properties
    
    @State private var scale: CGFloat = 1.0
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            Color(.gray0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Image(.logoMainBig)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 115.adjustedWidth, height: 76.adjustedHeight)
                .scaleEffect(scale)
                
        }
        .ignoresSafeArea()
        .onAppear {
            startScaleAnimation()
        }
    }
}

// MARK: - Functions

extension SplashView {
    private func startScaleAnimation() {
        withAnimation(
            .easeInOut(duration: 0.8)
            .repeatCount(10, autoreverses: true)
        ) {
            scale = 0.8
        }
    }
}
