//
//  PlaceCuratorHeader.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceCuratorHeader: View {
    
    // MARK: - Properties
    
    private let sheetState: SheetState
    private var onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        _ sheetState: SheetState,
        onTap: (() -> Void)? = nil
    ) {
        self.sheetState = sheetState
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(.logoMainSmall)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32.adjustedWidth, height: 21.adjustedHeight)
            
            switch sheetState {
            case .list:
                curatorHeader
            case .detail:
                curatorButton
            }
        }
    }
}

// MARK: - Subviews

extension PlaceCuratorHeader {
    private var curatorHeader: some View {
        Text("Discover your curated story")
            .applyGGFont(.body01)
            .foregroundStyle(.mainOrange500)
            .padding(.horizontal, 12.adjustedWidth)
            .padding(.vertical, 8.adjustedHeight)
    }
    
    private var curatorButton: some View {
        Button {
            onTap?()
        } label: {
            Text("Start your curated story")
                .applyGGFont(.body01)
                .foregroundStyle(.mainOrange500)
                .padding(.horizontal, 12.adjustedWidth)
                .padding(.vertical, 8.adjustedHeight)
                .background(.gray0)
                .cornerRadius(10, corners: .allCorners)
                .addBorder(.roundedRectangle(cornerRadius: 10), borderColor: .gray200, borderWidth: 1)
        }
        .buttonStyle(.plain)
        .padding(.leading, 10.adjustedWidth)
    }
}

#Preview {
    PlaceCuratorHeader(.list)
    PlaceCuratorHeader(.detail)
}
