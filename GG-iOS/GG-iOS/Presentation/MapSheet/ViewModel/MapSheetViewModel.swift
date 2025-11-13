//
//  MapSheetViewModel.swift
//  GG-iOS
//
//  Created by 김승원 on 10/8/25.
//

import MapKit
import SwiftUI

final class MapSheetViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var cameraPosition: MapCameraPosition
    @Published var sheetState: SheetState = .list
    @Published var mapPlaces: [MapPlace] = MapPlace.mockData
    @Published var bottomSheetHeight: CGFloat = SheetState.defaultHeight
    
    private let placeListService: PlaceListAPI
    
    // 임시 카메라 위치
    // TODO: - 바텀시트 내려감에 따라 지도 중심점 조정 필요
    private let initialLocation = CLLocationCoordinate2D(latitude: 37.5598, longitude: 126.9770)
    private let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    private let spanRate: Double = 0.45
    
    // MARK: - Action
    
    enum Action {
        case showMap
        case showList
        case selectMarker(_ mapPlace: MapPlace)
        case selectPlace(_ mapPlace: MapPlace)
        case switchSheetState(_ sheetState: SheetState)
    }
    
    // MARK: - Initializer
    
    init(placeListService: PlaceListAPI) {
        self.placeListService = placeListService
        
        let adjustedCenter = CLLocationCoordinate2D(
            latitude: initialLocation.latitude - (span.latitudeDelta * spanRate),
            longitude: initialLocation.longitude
        )
        
        cameraPosition = .region(MKCoordinateRegion(center: adjustedCenter, span: span))
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: Action) {
        switch action {
        case .showMap:
            bottomSheetHeight = SheetState.minimumHeight
            
        case .showList:
            bottomSheetHeight = SheetState.defaultHeight
            
        case .selectMarker(let mapPlace):
            selectMarker(mapPlace)
            setCameraPosition(coordinate: mapPlace.coordinate)
            sheetState = .detail
            
            withAnimation(.easeInOut(duration: 0.3)) {
                bottomSheetHeight = SheetState.defaultHeight
            }
            
        case .selectPlace(let mapPlace):
            selectMarker(mapPlace)
            setCameraPosition(coordinate: mapPlace.coordinate)
            sheetState = .detail
            
        case .switchSheetState(let sheetState):
            switch sheetState {
            case .list:
                break
                
            case .detail:
                deSelectMarker()
                self.sheetState = .list
            }
        }
    }
}

// MARK: - Private Functions

private extension MapSheetViewModel {
    func selectMarker(_ selectedPlace: MapPlace) {
        for index in mapPlaces.indices {
            if mapPlaces[index].id == selectedPlace.id {
                mapPlaces[index].isSelected = true
            } else {
                mapPlaces[index].isSelected = false
            }
        }
    }
    
    func deSelectMarker() {
        for index in mapPlaces.indices {
            mapPlaces[index].isSelected = false
        }
    }
    
    /// 카메라 위치를 변경합니다.
    func setCameraPosition(coordinate: CLLocationCoordinate2D) {
        withAnimation(.easeInOut(duration: 0.8)) {
            let adjustedCenter = CLLocationCoordinate2D(
                latitude: coordinate.latitude - (span.latitudeDelta * spanRate),
                longitude: coordinate.longitude
            )
            
            cameraPosition = .region(MKCoordinateRegion(center: adjustedCenter, span: span))
        }
    }
}

// MARK: - Functions

extension MapSheetViewModel {
    func isBottomSheetMinimumHeight() -> Bool {
        return bottomSheetHeight == SheetState.minimumHeight
    }
}

// MARK: - TempImageUrlString

enum TempImageUrlString {
    static func imageUrlString() -> String {
        return "https://gjicp.ggcf.kr/storage/upload/2023/02/28/5XtjWZqT1Lbw29sY26OdFgRWhM5LQ1YJ3ZmNMuIa.jpg"
    }
    
    static func threeImageUrlStrings() -> [String] {
        return [
            imageUrlString(),
            imageUrlString(),
            imageUrlString()
        ]
    }
}
