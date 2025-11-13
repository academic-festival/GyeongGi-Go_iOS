//
//  PlaceListAPI.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

protocol PlaceListAPI {
    /// 홈화면 조회(장소 리스트 조회)
    func fetchPlaceList(request: PlaceListRequestDTO) async throws -> BaseResponseBody<PlaceListResponseDTO>
}
