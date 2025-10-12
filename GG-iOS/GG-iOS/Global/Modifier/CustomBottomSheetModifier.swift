//
//  CustomBottomSheetModifier.swift
//  GG-iOS
//
//  Created by 김승원 on 10/8/25.
//

import SwiftUI

struct CustomBottomSheetModifier<TopContent: View, SheetContent: View>: ViewModifier {
    
    // MARK: - Properties
    
    @State private var currentHeight: CGFloat = 400.adjustedHeight
    @State private var topContentOpacity: Double = 1.0
    
    private let defaultHeight: CGFloat = 400.adjustedHeight
    private let minimumHeight: CGFloat = 110.adjustedHeight
    private let maximumHeight: CGFloat = 692.adjustedHeight
    
    private let topContent: () -> TopContent
    private let sheetContent: () -> SheetContent
    
    // MARK: - Initializer
    
    init(
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self.topContent = topContent
        self.sheetContent = sheetContent
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            ZStack(alignment: .top) {
                sheet
                    .frame(height: currentHeight)
                
                topContent()
                    .opacity(topContentOpacity)
                    .offset(y: -50.adjustedHeight)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Subviews

extension CustomBottomSheetModifier {
    private var indicator: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundStyle(.gray200)
                .frame(width: 43.adjustedWidth, height: 3.adjustedHeight)
                .capsuleClipped()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 37.adjustedHeight)
    }
    
    private var sheet: some View {
        VStack(alignment: .center, spacing: 0){
            indicator
            
            sheetContent()
                .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.gray0)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(color: .gray900.opacity(0.15), radius: 10, x: 0, y: 0)
        .gesture(dragGesture)
    }
}

// MARK: - Functions

extension CustomBottomSheetModifier {
    private func updateTopContentOpacity() {
        let fadeRange: CGFloat = 70.adjustedHeight
        
        if currentHeight <= maximumHeight - fadeRange {
            topContentOpacity = 1.0
        } else if currentHeight <= maximumHeight {
            topContentOpacity = 1.0 - ((currentHeight - (maximumHeight - fadeRange)) / fadeRange)
        } else {
            topContentOpacity = 0.0
        }
    }
}

// MARK: - Gestures

extension CustomBottomSheetModifier {
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let newHeight = currentHeight - value.translation.height
                let clampedHeight = min(max(newHeight, minimumHeight), maximumHeight)
                currentHeight = clampedHeight
                
                updateTopContentOpacity()
            }
            .onEnded { value in
                let newHeight = currentHeight - value.translation.height
                let midPoint = (defaultHeight + maximumHeight) / 2
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    if newHeight <= defaultHeight - 200.adjustedHeight {
                        currentHeight = minimumHeight
                    } else if newHeight > midPoint {
                        currentHeight = maximumHeight
                    } else {
                        currentHeight = defaultHeight
                    }
                    
                    updateTopContentOpacity()
                }
            }
    }
}

// MARK: - Modifier

extension View {
    func customBottomSheet<TopContent: View, SheetContent: View>(
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(
            CustomBottomSheetModifier(
                topContent: topContent,
                sheetContent: sheetContent
            )
        )
    }
}
