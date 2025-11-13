//
//  PlaceListService.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

final class PlaceListService: BaseService<PlaceListTargetType> { }

extension PlaceListService: PlaceListAPI {
    func fetchPlaceList(request: PlaceListRequestDTO) async throws -> BaseResponseBody<PlaceListResponseDTO> {
        return try await self.request(with: .fetchPlaceList(request: request))
    }
}
