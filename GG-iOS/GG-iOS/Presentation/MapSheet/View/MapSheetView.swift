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
                        viewModel.dispatch(.selectMarker(mapPlace))
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
            switch viewModel.sheetState {
            case .list:
                break
                // TODO: - 바텀시트 내리기
            case .detail:
                viewModel.dispatch(.switchSheetState(.detail))
            }
        } label: {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                Image(viewModel.sheetState == .list ? .showMapIcon : .showListIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16.adjusted, height: 16.adjusted)
                
                Text(viewModel.sheetState == .list ? "Show map" : "Show list")
                    .applyGGFont(.body02)
                    .foregroundStyle(.textNatural)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.vertical, 8.adjustedHeight)
            .background(.gray0)
            .capsuleClipped()
            .addBorder(.capsule, borderColor: .gray200, borderWidth: 1)
            .animation(.easeInOut(duration: 0.1), value: viewModel.sheetState)
        }
        .buttonStyle(.plain)
    }
    
    private var sheetContent: some View {
        Group {
            switch viewModel.sheetState {
            case .list:
                PlaceListView(viewModel: viewModel)
            case .detail:
                PlaceDetailView(viewModel: viewModel) {
                    appCoordinator.navigate(to: .chat)
                }
            }
        }
    }
}

#Preview {
    MapSheetView()
        .environmentObject(AppCoordinator())
}
