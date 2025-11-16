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
    private let isLoading: Bool
    private var onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        address: String,
        imageUrlStrings: [String],
        isLoading: Bool,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.address = address
        self.imageUrlStrings = imageUrlStrings
        self.isLoading = isLoading
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
        .disabled(isLoading)
    }
}

// MARK: - Subviews

extension PlaceListRow {
    private var titleSection: some View {
        Text(title)
            .applyGGFont(.heading02)
            .foregroundStyle(.textNatural)
            .customSkeleton(
                with: isLoading,
                size: CGSize(width: 148.adjustedWidth, height: 21.adjustedHeight),
                radius: 5
            )
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
        .customSkeleton(
            with: isLoading,
            size: CGSize(width: 280.adjustedWidth, height: 14.adjustedHeight),
            radius: 5
        )
        
    }
    
    private var photos: some View {
        HStack(alignment: .center, spacing: 2.5.adjustedWidth) {
            ForEach(imageUrlStrings, id: \.self) { imageString in
                KFImage(URL(string: imageString))
                    .onFailureImage(.tempImageIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .customSkeleton(with: isLoading)
                    .frame(width: 110.adjustedWidth, height: 80.adjustedHeight)
                    .background(.gray300)
                    .cornerRadius(10, corners: .allCorners)
            }
            
            ForEach(0..<(3 - imageUrlStrings.count), id: \.self) { _ in
                Image(.tempImageIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110.adjustedWidth, height: 80.adjustedHeight)
                    .cornerRadius(10, corners: .allCorners)
            }
        }
    }
}

#Preview {
    PlaceListRow(
        title: "Suwon Hwaseong",
        address: "320-2 Hwajeong-dong, Jangan-gu, Suwon-si",
        imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
        isLoading: false
    )
    .padding(.horizontal, 20.adjustedWidth)
    
    PlaceListRow(
        title: "Suwon Hwaseong",
        address: "320-2 Hwajeong-dong, Jangan-gu, Suwon-si",
        imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
        isLoading: true
    )
    .padding(.horizontal, 20.adjustedWidth)
}
