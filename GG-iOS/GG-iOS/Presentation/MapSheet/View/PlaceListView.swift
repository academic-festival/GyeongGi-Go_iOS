//
//  PlaceListView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceListView: View {

    // MARK: - Properties
    
    @ObservedObject private var viewModel: MapSheetViewModel
    
    // MARK: - Initializer
    
    init(viewModel: MapSheetViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 24.adjustedHeight) {
                header
                
                placeList
            }
        }
    }
}

// MARK: - Subviews

extension PlaceListView {
    private var header: some View {
        PlaceCuratorHeader(.list)
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.top, 20.adjustedHeight)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var placeList: some View {
        VStack(alignment: .center, spacing: 20.adjustedHeight) {
            ForEach(viewModel.mapPlaces) { mapPlace in
                PlaceListRow(
                    title: mapPlace.name,
                    address: mapPlace.address,
                    imageUrlStrings: mapPlace.imageUrlStrings,
                    onTap: {
                        viewModel.sheetState = .detail
                    }
                )
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}

#Preview {
    PlaceListView(viewModel: MapSheetViewModel())
}
