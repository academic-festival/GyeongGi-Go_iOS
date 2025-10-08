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
    let coordinate: CLLocationCoordinate2D
    var isSelected: Bool = false
}
