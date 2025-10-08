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
    
    // 지도에 표시할 임시 마커
    @Published var mapPlaces: [MapPlace] = [
        MapPlace(name: "서울역", coordinate: CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9707)),
        MapPlace(name: "남대문시장", coordinate: CLLocationCoordinate2D(latitude: 37.5598, longitude: 126.9770)),
        MapPlace(name: "회현역", coordinate: CLLocationCoordinate2D(latitude: 37.5584, longitude: 126.9780))
    ]
    
    // 임시 카메라 위치
    let initialLocation = CLLocationCoordinate2D(latitude: 37.5598, longitude: 126.9770)
    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
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
