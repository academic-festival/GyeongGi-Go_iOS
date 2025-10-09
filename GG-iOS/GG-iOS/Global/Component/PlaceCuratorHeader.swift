//
//  PlaceCuratorHeader.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceCuratorHeader: View {
    
    // MARK: - Properties
    
    private var onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 10.adjustedWidth) {
            Image(.logoMainSmall)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32.adjustedWidth, height: 21.adjustedHeight)
            
            Button {
                onTap?()
            } label: {
                Text("Discover your curated story")
                    .applyGGFont(.body01)
                    .foregroundStyle(.mainOrange500)
                    .padding(.horizontal, 12.adjustedWidth)
                    .padding(.vertical, 8.adjustedHeight)
                    .background(.gray0)
                    .cornerRadius(10, corners: .allCorners)
                    .addBorder(.roundedRectangle(cornerRadius: 10), borderColor: .gray200, borderWidth: 1)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    PlaceCuratorHeader()
}
