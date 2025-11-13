//
//  MapPlace.swift
//  GG-iOS
//
//  Created by 김승원 on 10/8/25.
//

import MapKit
import SwiftUI

/// 지도에 표시할 마커 모델입니다.
struct MapPlace: Identifiable {
    var id: Int { placeId }
    let placeId: Int
    let placeName: String
    let address: String
    let imageUrlStrings: [String]
    let coordinate: CLLocationCoordinate2D
    var isSelected: Bool = false
}

extension MapPlace {
    init(from dto: PlaceResponseDTO) {
        self.placeId = dto.placeId
        self.placeName = dto.placeName
        self.address = dto.address
        self.imageUrlStrings = dto.placeImages
        self.coordinate = CLLocationCoordinate2D(latitude: dto.y, longitude: dto.x)
    }
}

extension MapPlace {
    static var mockData: [MapPlace] {
        [
            MapPlace(
                placeId: 153,
                placeName: "Seoul Station",
                address: "175, Mallijae-ro, Jung-gu, Seoul, Republic of Korea",
                imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.5547,
                    longitude: 126.9707
                )
            ),
            MapPlace(
                placeId: 2,
                placeName: "Namdaemun Market",
                address: "45-2, Namdaemunsijang-gil, Jung-gu, Seoul, Republic of Korea",
                imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.5598,
                    longitude: 126.9770
                )
            ),
            MapPlace(
                placeId: 3,
                placeName: "Hoehyeon Station",
                address: "54, Toegye-ro, Jung-gu, Seoul, Republic of Korea",
                imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.5584,
                    longitude: 126.9780
                )
            )
        ]
    }
}

extension MapPlace {
    static var skeletonData: [MapPlace] {
        [
            MapPlace(
                placeId: 1,
                placeName: "",
                address: "",
                imageUrlStrings: ["1", "2", "3"],
                coordinate: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0
                )
            ),
            MapPlace(
                placeId: 2,
                placeName: "",
                address: "",
                imageUrlStrings: ["4", "5", "6"],
                coordinate: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0
                )
            ),
            MapPlace(
                placeId: 3,
                placeName: "",
                address: "",
                imageUrlStrings: ["7", "8", "9"],
                coordinate: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0
                )
            )
        ]
    }
}
