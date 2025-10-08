//
//  PlaceListView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceListView: View {

    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // MARK: - Initializer
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24.adjustedHeight) {
                header
                
                placeList
            }
        }
    }
}

// MARK: - Subviews

extension PlaceListView {
    private var header: some View {
        PlaceCuratorHeader() {
            // TODO: - 큐레이터 연결
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 20.adjustedHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var placeList: some View {
        VStack(alignment: .center, spacing: 20.adjustedHeight) {
            PlaceListRow() {
                appCoordinator.switchTab(to: .detail)
            }
            PlaceListRow()
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}

#Preview {
    PlaceListView()
        .environmentObject(AppCoordinator())
}
