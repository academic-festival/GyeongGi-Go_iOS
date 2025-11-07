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
    let id = UUID()
    let name: String
    let address: String
    let imageUrlStrings: [String]
    let coordinate: CLLocationCoordinate2D
    var isSelected: Bool = false
}

extension MapPlace {
    static var mockData: [MapPlace] {
        [
            MapPlace(
                name: "Seoul Station",
                address: "175, Mallijae-ro, Jung-gu, Seoul, Republic of Korea",
                imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.5547,
                    longitude: 126.9707
                )
            ),
            MapPlace(
                name: "Namdaemun Market",
                address: "45-2, Namdaemunsijang-gil, Jung-gu, Seoul, Republic of Korea",
                imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.5598,
                    longitude: 126.9770
                )
            ),
            MapPlace(
                name: "Hoehyeon Station",
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
