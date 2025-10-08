//
//  MapSheetView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/8/25.
//

import MapKit
import SwiftUI

struct MapSheetView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = MapSheetViewModel()
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .top) {
            map
                .customBottomSheet(
                    topContent: {
                        topContent
                    },
                    sheetContent: {
                        sheetContent
                    }
                )
            
            address
        }
    }
}

// MARK: - Subview

extension MapSheetView {
    private var map: some View {
        Map(position: $viewModel.cameraPosition) {
            ForEach($viewModel.mapPlaces) { $mapPlace in
                Annotation(mapPlace.name, coordinate: mapPlace.coordinate) {
                    GGMarker(isSelected: mapPlace.isSelected) {
                        viewModel.selectMarker(mapPlace)
                        viewModel.setCameraPosition(coordinate: mapPlace.coordinate)
                    }
                }
                .annotationTitles(.hidden)
            }
        }
        .mapControlVisibility(.hidden)
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
    }
    
    private var address: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 336.adjustedWidth, height: 48.adjustedHeight)
                .foregroundStyle(.gray0)
                .cornerRadius(10, corners: .allCorners)
                .addBorder(.roundedRectangle(cornerRadius: 10), borderColor: .gray100, borderWidth: 1)
            
            Text("320 - 2 Hwajeong-dong Jangan-gu Suwon-si")
                .applyGGFont(.body02)
                .foregroundStyle(.textNatural)
                .lineLimit(1)
                .frame(width: 304.adjustedWidth)
                .padding(.horizontal, 16.adjustedWidth)
        }
            
    }
    
    private var topContent: some View {
        Button {
            
        } label: {
            ZStack(alignment: .center) {
                Capsule()
                    .frame(width: 121.adjustedWidth, height: 34.adjustedHeight)
                    .foregroundStyle(.gray0)
                    .addBorder(.capsule, borderColor: .gray200, borderWidth: 1)
                
                HStack(alignment: .center, spacing: 8.adjustedWidth) {
                    Image(.showMapIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16.adjustedWidth, height: 16.adjustedHeight)
                    
                    Text("show map")
                        .applyGGFont(.body02)
                        .foregroundStyle(.textNatural)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    private var sheetContent: some View {
        Text("sheet Content")
    }
}

#Preview {
    MapSheetView()
}
