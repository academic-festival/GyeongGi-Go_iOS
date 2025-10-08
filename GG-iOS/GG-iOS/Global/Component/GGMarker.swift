//
//  GGMarker.swift
//  GG-iOS
//
//  Created by 김승원 on 10/8/25.
//

import SwiftUI

struct GGMarker: View {
    
    // MARK: - Properties
    
    private let isSelected: Bool
    private let onTapped: (() -> Void)?
    
    private let defaultWidth: CGFloat = 24.adjustedWidth
    private let defaultHeight: CGFloat = 24.adjustedHeight
    private let selectedWidth: CGFloat = 38.adjustedWidth
    private let selectedHeight: CGFloat = 52.adjustedHeight
    private let heightOffset: CGFloat = 20.adjustedHeight
    
    // MARK: - Initializer
    
    init(isSelected: Bool, onTapped: (() -> Void)? = nil) {
        self.isSelected = isSelected
        self.onTapped = onTapped
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTapped?()
        } label: {
            GeometryReader { geometry in
                Image(isSelected ? .markerSelected : .markerDefault)
                    .resizable()
                    .renderingMode(.original)
                    .frame(
                        width: isSelected ? selectedWidth : defaultWidth,
                        height: isSelected ? selectedHeight : defaultHeight
                    )
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height - (isSelected ? selectedHeight / 2 : defaultHeight / 2)
                    )
                    .animation(.bouncy(duration: 0.25, extraBounce: 0.25), value: isSelected)
            }
            .frame(
                width: selectedWidth,
                height: selectedHeight + heightOffset
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    GGMarker(isSelected: false)
}
