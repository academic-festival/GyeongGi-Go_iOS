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
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
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
            // TODO: - list일 때 sheet 내리기, detail일 때 list로 바꾸기
        } label: {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                Image(appCoordinator.sheetState == .list ? .showMapIcon : .showListIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16.adjustedWidth, height: 16.adjustedHeight)
                
                Text(appCoordinator.sheetState == .list ? "Show map" : "Show list")
                    .applyGGFont(.body02)
                    .foregroundStyle(.textNatural)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.vertical, 8.adjustedHeight)
            .background(.gray0)
            .capsuleClipped()
            .addBorder(.capsule, borderColor: .gray200, borderWidth: 1)
            .animation(.easeInOut(duration: 0.1), value: appCoordinator.sheetState)
        }
        .buttonStyle(.plain)
    }
    
    private var sheetContent: some View {
        Group {
            switch appCoordinator.sheetState {
            case .list:
                PlaceListView() {
                    appCoordinator.switchTab(to: .detail)
                }
            case .detail:
                PlaceDetailView() {
                    appCoordinator.switchTab(to: .list)
                }
            }
        }
    }
}

#Preview {
    MapSheetView()
        .environmentObject(AppCoordinator())
}
