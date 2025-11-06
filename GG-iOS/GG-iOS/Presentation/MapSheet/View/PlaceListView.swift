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
    
    private var onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(viewModel: MapSheetViewModel, onTap: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
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
            PlaceListRow() {
                onTap?()
            }
            PlaceListRow()
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}

#Preview {
    PlaceListView(viewModel: MapSheetViewModel())
}
