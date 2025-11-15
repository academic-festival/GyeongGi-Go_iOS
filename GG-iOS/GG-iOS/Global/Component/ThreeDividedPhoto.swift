//
//  ThreeDividedPhoto.swift
//  GG-iOS
//
//  Created by 김승원 on 11/16/25.
//

import SwiftUI

import Kingfisher

struct ThreeDividedPhoto: View {
    
    // MARK: - Properties
    
    private let imageUrlStrings: [String]
    private let isLoading: Bool
    
    // MARK: - Initializer
    
    init(imageUrlStrings: [String], isLoading: Bool) {
        self.imageUrlStrings = imageUrlStrings
        self.isLoading = isLoading
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            if imageUrlStrings.count < 1 {
                tempImage
                    .frame(width: 218.adjustedWidth, height: 168.adjustedHeight)
                    .cornerRadius(10, corners: .allCorners)
            } else {
                KFImage(URL(string: imageUrlStrings[0]))
                    .onFailureImage(.tempImageIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .customSkeleton(with: isLoading)
                    .frame(width: 218.adjustedWidth, height: 168.adjustedHeight)
                    .cornerRadius(10, corners: .allCorners)
            }
            
            VStack(alignment: .center, spacing: 8.adjustedHeight) {
                if imageUrlStrings.count < 2 {
                    tempImage
                        .frame(width: 110.adjustedWidth, height: 80.adjustedHeight)
                        .cornerRadius(10, corners: .allCorners)
                } else {
                    KFImage(URL(string: imageUrlStrings[1]))
                        .onFailureImage(.tempImageIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .customSkeleton(with: isLoading)
                        .frame(width: 110.adjustedWidth, height: 80.adjustedHeight)
                        .cornerRadius(10, corners: .allCorners)
                }
                
                if imageUrlStrings.count < 3 {
                    tempImage
                        .frame(width: 110.adjustedWidth, height: 80.adjustedHeight)
                        .cornerRadius(10, corners: .allCorners)
                } else {
                    KFImage(URL(string: imageUrlStrings[2]))
                        .onFailureImage(.tempImageIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .customSkeleton(with: isLoading)
                        .frame(width: 110.adjustedWidth, height: 80.adjustedHeight)
                        .cornerRadius(10, corners: .allCorners)
                }
            }
        }
    }
}

// MARK: - Subviews

extension ThreeDividedPhoto {
    private var tempImage: some View {
        Image(.tempImageIcon)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .customSkeleton(with: isLoading)
    }
}

#Preview {
    ThreeDividedPhoto(
        imageUrlStrings: [],
        isLoading: false
    )
}
