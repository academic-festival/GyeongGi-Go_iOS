//
//  PlaceListRow.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

import Kingfisher

struct PlaceListRow: View {
    
    // MARK: - Properties
    
    private let title: String
    private let address: String
    private let imageUrlStrings: [String]
    private var onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        address: String,
        imageUrlStrings: [String],
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.address = address
        self.imageUrlStrings = imageUrlStrings
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                titleSection
                    .padding(.bottom, 4.adjustedHeight)
                
                addressSection
                    .padding(.bottom, 12.adjustedHeight)
                
                photos
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Subviews

extension PlaceListRow {
    private var titleSection: some View {
        Text(title)
            .applyGGFont(.heading02)
            .foregroundStyle(.textNatural)
    }
    
    private var addressSection: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Image(.address12Icon)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12.adjusted, height: 12.adjusted)
                .foregroundStyle(.textLight)
            
            Text(address)
                .applyGGFont(.label02)
                .foregroundStyle(.textLight)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var photos: some View {
        HStack(alignment: .center, spacing: 2.5.adjustedWidth) {
            ForEach(imageUrlStrings, id: \.self) { imageString in
                KFImage(URL(string: imageString))
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
    PlaceListRow(
        title: "Suwon Hwaseong",
        address: "320-2 Hwajeong-dong, Jangan-gu, Suwon-si",
        imageUrlStrings: TempImageUrlString.threeImageUrlStrings()
    )
}
