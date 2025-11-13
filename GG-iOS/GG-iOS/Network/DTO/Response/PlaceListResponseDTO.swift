//
//  PlaceListResponseDTO.swift
//  GG-iOS
//
//  Created by 김승원 on 11/12/25.
//

import Foundation

struct PlaceListResponseDTO: ResponseModelType {
    let placeList: [PlaceResponseDTO]
}

struct PlaceResponseDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let address: String
    let x: Double
    let y: Double
    let placeImages: [String]
}
