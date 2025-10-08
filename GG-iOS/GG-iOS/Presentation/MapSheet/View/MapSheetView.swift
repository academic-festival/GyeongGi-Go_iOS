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
        ZStack(alignment: .bottom) {
            map
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
}

#Preview {
    MapSheetView()
}
