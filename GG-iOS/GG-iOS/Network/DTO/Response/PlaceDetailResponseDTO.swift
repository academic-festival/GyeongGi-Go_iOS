//
//  PlaceDetailResponseDTO.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

struct PlaceDetailResponseDTO: ResponseModelType {
    let placeId: Int
    let placeName: String
    let address: String
    let placeImages: [String]
    let locationExplain: String
    let price: String?
    let inquiry: String
}
