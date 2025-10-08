//
//  PlaceListRow.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceListRow: View {
    
    // MARK: - Properties
    
    private var onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                title
                    .padding(.bottom, 4.adjustedHeight)
                
                address
                    .padding(.bottom, 12.adjustedHeight)
                
                photos
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Subviews

extension PlaceListRow {
    private var title: some View {
        Text("Suwon Hwaseong")
            .applyGGFont(.heading02)
            .foregroundStyle(.textNatural)
    }
    
    private var address: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Image(.address12Icon)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12.adjustedWidth, height: 12.adjustedHeight)
                .foregroundStyle(.textLight)
            
            Text("320-2 Hwajeong-dong, Jangan-gu, Suwon-si")
                .applyGGFont(.label02)
                .foregroundStyle(.textLight)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var photos: some View {
        HStack(alignment: .center, spacing: 2.5.adjustedWidth) {
            ForEach(0..<3) { _ in
                Image(.temp)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 80.adjustedHeight)
                    .background(.gray300)
                    .cornerRadius(10, corners: .allCorners)
            }
        }
    }
}

#Preview {
    PlaceListRow()
}
