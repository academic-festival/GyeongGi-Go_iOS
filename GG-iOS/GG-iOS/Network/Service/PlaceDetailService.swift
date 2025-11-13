//
//  PlaceDetailService.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

final class PlaceDetailService: BaseService<PlaceDetailTargetType> { }

extension PlaceDetailService {
    func fetchPlaceDetail(placeId: Int) async throws -> BaseResponseBody<PlaceResponseDTO> {
        return try await self.request(with: .fetchPlaceDetail(placeId: placeId))
    }
}
