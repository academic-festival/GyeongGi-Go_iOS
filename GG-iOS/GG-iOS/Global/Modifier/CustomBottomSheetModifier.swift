//
//  CustomBottomSheetModifier.swift
//  GG-iOS
//
//  Created by 김승원 on 10/8/25.
//

import SwiftUI

struct CustomBottomSheetModifier<TopContent: View, SheetContent: View>: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var currentHeight: CGFloat
    @State private var topContentOpacity: Double = 1.0
    
    private let topContent: () -> TopContent
    private let sheetContent: () -> SheetContent
    
    // MARK: - Initializer
    
    init(
        currentHeight: Binding<CGFloat>,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self._currentHeight = currentHeight
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
        
        if currentHeight <= SheetState.maximumHeight - fadeRange {
            topContentOpacity = 1.0
        } else if currentHeight <= SheetState.maximumHeight {
            topContentOpacity = 1.0 - ((currentHeight - (SheetState.maximumHeight - fadeRange)) / fadeRange)
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
                let clampedHeight = min(max(newHeight, SheetState.minimumHeight), SheetState.maximumHeight)
                currentHeight = clampedHeight
                
                updateTopContentOpacity()
            }
            .onEnded { value in
                let newHeight = currentHeight - value.translation.height
                let midPoint = (SheetState.defaultHeight + SheetState.maximumHeight) / 2
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    if newHeight <= SheetState.defaultHeight - 200.adjustedHeight {
                        currentHeight = SheetState.minimumHeight
                    } else if newHeight > midPoint {
                        currentHeight = SheetState.maximumHeight
                    } else {
                        currentHeight = SheetState.defaultHeight
                    }
                    
                    updateTopContentOpacity()
                }
            }
    }
}

// MARK: - Modifier

extension View {
    func customBottomSheet<TopContent: View, SheetContent: View>(
        currentHeight: Binding<CGFloat>,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(
            CustomBottomSheetModifier(
                currentHeight: currentHeight,
                topContent: topContent,
                sheetContent: sheetContent
            )
        )
    }
}
