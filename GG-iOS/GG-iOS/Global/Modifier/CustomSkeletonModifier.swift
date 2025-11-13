//
//  CustomSkeletonModifier.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import SwiftUI

import SkeletonUI

struct CustomSkeletonModifier: ViewModifier {
    private let isLoading: Bool
    private let size: CGSize?
    private let radius: CGFloat
    private let lines: Int
    
    init(isLoading: Bool, size: CGSize?, radius: CGFloat, lines: Int) {
        self.isLoading = isLoading
        self.size = size
        self.radius = radius
        self.lines = lines
    }
    
    func body(content: Content) -> some View {
        content
            .skeleton(
                with: isLoading,
                size: size,
                shape: .rounded(.radius(radius)),
                lines: lines
            )
    }
}

extension View {
    func customSkeleton(
        with isLoading: Bool,
        size: CGSize? = nil,
        radius: CGFloat = 10,
        lines: Int = 1
    ) -> some View {
        self.modifier(
            CustomSkeletonModifier(
                isLoading: isLoading,
                size: size,
                radius: radius,
                lines: lines
            )
        )
    }
}
