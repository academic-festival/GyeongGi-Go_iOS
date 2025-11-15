//
//  PlaceDetailView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

import Kingfisher

struct PlaceDetailView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: MapSheetViewModel
    
    private let onTap: ((Int, String, String) -> Void)?
    
    // MARK: - Initializer
    
    init(viewModel: MapSheetViewModel, onTap: ((Int, String, String) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 0) {
                header
                    .padding(.bottom, 16.adjustedHeight)
                
                details
                    .padding(.bottom, 24.adjustedHeight)
                
                if viewModel.placeDetail.description != nil {
                    divider
                        .padding(.bottom, 24.adjustedHeight)
                    
                    description
                }
                
                scrollSpacer
            }
        }
        .background(.gray0)
        .disabled(viewModel.isPlaceDetailLoading)
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    private var header: some View {
        PlaceCuratorHeader(.detail) {
            onTap?(
                viewModel.placeDetail.placeId,
                viewModel.placeDetail.placeName,
                viewModel.placeDetail.address
            )
        }
        .padding(.leading, 20.adjustedWidth)
        .padding(.top, 20.adjustedHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var details: some View {
        VStack(alignment: .center, spacing: 20.adjustedHeight) {
            title
                .padding(.horizontal, 20.adjustedWidth)
            
            photos
            
            informations
                .padding(.horizontal, 20.adjustedWidth)
        }
    }
    
    private var title: some View {
        Text(viewModel.placeDetail.placeName)
            .applyGGFont(.title02)
            .foregroundStyle(.textNatural)
            .lineLimit(1)
            .customSkeleton(
                with: viewModel.isPlaceDetailLoading,
                size: CGSize(width: 250.adjustedWidth, height: 35.adjustedHeight),
                radius: 8
            )
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var photos: some View {
        ThreeDividedPhoto(
            imageUrlStrings: viewModel.placeDetail.imageUrlStrings,
            isLoading: viewModel.isPlaceDetailLoading
        )
    }
    
    private var informations: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            InformationWithIconRow(
                InformationWithIcon(
                    informationType: .address,
                    text: viewModel.placeDetail.address
                )
            )
            .customSkeleton(
                with: viewModel.isPlaceDetailLoading,
                size: CGSize(width: 335.adjustedWidth, height: 16.adjustedHeight),
                radius: 5
            )
            
            InformationWithIconRow(
                InformationWithIcon(
                    informationType: .url,
                    text: viewModel.placeDetail.inquiry
                )
            )
            .customSkeleton(
                with: viewModel.isPlaceDetailLoading,
                size: CGSize(width: 335.adjustedWidth, height: 16.adjustedHeight),
                radius: 5
            )
            
            if let price = viewModel.placeDetail.price {
                InformationWithIconRow(
                    InformationWithIcon(
                        informationType: .price,
                        text: price
                    )
                )
                .customSkeleton(
                    with: viewModel.isPlaceDetailLoading,
                    size: CGSize(width: 335.adjustedWidth, height: 16.adjustedHeight),
                    radius: 5
                )
            }
        }
    }
    
    private var divider: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 6.adjustedHeight)
            .foregroundStyle(.gray100)
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            Text("Description")
                .applyGGFont(.heading02)
                .foregroundStyle(.textNatural)
            
            Text(viewModel.placeDetail.description)
                .applyGGFont(.body02)
                .foregroundStyle(.textNormal)
                .frame(width: 335.adjustedWidth, alignment: .leading)
                .customSkeleton(
                    with: viewModel.isPlaceDetailLoading,
                    size: CGSize(width: 335.adjustedWidth, height: 55.adjustedHeight),
                    radius: 4,
                    lines: 3
                )
        }
    }
    
    private var scrollSpacer: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 100.adjustedHeight)
            .foregroundStyle(.clear)
    }
}
