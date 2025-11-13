//
//  PlaceDetailAPI.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

protocol PlaceDetailAPI {
    /// 장소 상세 조회
    func fetchPlaceDetail(placeId: Int) async throws -> BaseResponseBody<PlaceDetailResponseDTO>
}
