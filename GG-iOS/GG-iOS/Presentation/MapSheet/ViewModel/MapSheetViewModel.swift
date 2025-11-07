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
    
    // 임시 카메라 위치
    private let initialLocation = CLLocationCoordinate2D(latitude: 37.5598, longitude: 126.9770)
    private let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    private let spanRate: Double = 0.45
    
    // MARK: - Initializer
    
    init() {
        let adjustedCenter = CLLocationCoordinate2D(
            latitude: initialLocation.latitude - (span.latitudeDelta * spanRate),
            longitude: initialLocation.longitude
        )
        
        cameraPosition = .region(MKCoordinateRegion(center: adjustedCenter, span: span))
    }
}

// MARK: - Functions

extension MapSheetViewModel {
    func selectMarker(_ selectedPlace: MapPlace) {
        for index in mapPlaces.indices {
            if mapPlaces[index].id == selectedPlace.id {
                mapPlaces[index].isSelected.toggle()
            } else {
                mapPlaces[index].isSelected = false
            }
        }
    }
    
    /// 카메라 위치를 변경합니다.
    func setCameraPosition(coordinate: CLLocationCoordinate2D) {
        withAnimation(.easeInOut(duration: 0.5)) {
            let adjustedCenter = CLLocationCoordinate2D(
                latitude: coordinate.latitude - (span.latitudeDelta * spanRate),
                longitude: coordinate.longitude
            )
            
            cameraPosition = .region(MKCoordinateRegion(center: adjustedCenter, span: span))
        }
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
