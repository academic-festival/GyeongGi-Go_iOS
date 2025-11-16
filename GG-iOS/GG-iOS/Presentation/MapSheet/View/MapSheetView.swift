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
    @StateObject private var viewModel: MapSheetViewModel
    
    // MARK: - Initializer
    
    init() {
        self._viewModel = StateObject(
            wrappedValue: MapSheetViewModel(
                placeListService: PlaceListService(),
                placeDetailService: PlaceDetailService()
            )
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .top) {
            map
                .customBottomSheet(
                    currentHeight: $viewModel.bottomSheetHeight,
                    topContent: {
                        topContent
                    },
                    sheetContent: {
                        sheetContent
                            .frame(width: 375.adjustedWidth)
                    }
                )
            
            address
            
            SplashView()
                .opacity(viewModel.shouldDisplaySplash ? 1.0 : 0)
        }
        .onAppear {
            viewModel.dispatch(.fetchPlaceList)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.dispatch(.stopSplash)
            }
        }
        .alert(isPresented: $viewModel.shouldShowErrorAlert) {
            Alert(
                title: Text(viewModel.alertErrorMessage),
                message: nil,
                dismissButton: .default(Text("retry")) {
//                    viewModel.dispatch(.fetchPlaceList)
                }
            )
        }
    }
}

// MARK: - Subview

extension MapSheetView {
    private var map: some View {
        Map(position: $viewModel.cameraPosition) {
            ForEach($viewModel.mapPlaces, id: \.id) { $mapPlace in
                Annotation(mapPlace.placeName, coordinate: mapPlace.coordinate) {
                    GGMarker(isSelected: mapPlace.isSelected) {
                        viewModel.dispatch(.selectMarker(mapPlace))
                    }
                }
                .annotationTitles(.hidden)
            }
            
            Annotation("", coordinate: viewModel.userLocation()) {
                UserMarker()
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
            
            Text(viewModel.userAddress)
                .applyGGFont(.body02)
                .foregroundStyle(.textNatural)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 304.adjustedWidth)
                .padding(.horizontal, 16.adjustedWidth)
        }
    }
    
    private var topContent: some View {
        ZStack(alignment: .center) {
            Button {
                switch viewModel.sheetState {
                case .list:
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if viewModel.isBottomSheetMinimumHeight() {
                            viewModel.dispatch(.showList)
                        } else {
                            viewModel.dispatch(.showMap)
                        }
                    }
                case .detail:
                    
                    if viewModel.isBottomSheetMinimumHeight() {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.dispatch(.showList)
                        }
                    } else {
                        viewModel.dispatch(.switchSheetState(.detail))
                    }
                }
            } label: {
                HStack(alignment: .center, spacing: 8.adjustedWidth) {
                    Image(
                        viewModel.isBottomSheetMinimumHeight()
                        ? .showListIcon : viewModel.sheetState == .list
                        ? .showMapIcon : .showListIcon
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16.adjusted, height: 16.adjusted)
                    
                    Text(
                        viewModel.isBottomSheetMinimumHeight()
                        ? "Show list" : viewModel.sheetState == .list
                        ? "Show map" : "Show list"
                    )
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
            .contentShape(Rectangle())
            
            HStack(alignment: .center, spacing: 0) {
                Button {
                    viewModel.dispatch(.setCameraToUser)
                } label: {
                    Image(.locationSetIcon)
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28.adjusted, height: 28.adjusted)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 2.adjustedHeight)
            .padding(.trailing, 20.adjustedWidth)
        }
    }
    
    private var sheetContent: some View {
        ZStack(alignment: .center) {
            PlaceListView(viewModel: viewModel)
            
            if viewModel.sheetState == .detail {
                PlaceDetailView(viewModel: viewModel) { placeId, placeName, address in
                    appCoordinator.navigate(
                        to: .chat(
                            placeId: placeId,
                            placeName: placeName,
                            address: address
                        )
                    )
                }
                .animation(nil, value: viewModel.placeDetail)
            }
        }
    }
}

#Preview {
    MapSheetView()
        .environmentObject(AppCoordinator())
}
