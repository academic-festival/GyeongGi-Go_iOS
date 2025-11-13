//
//  PlaceListTargetType.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

import Moya

enum PlaceListTargetType {
    case fetchPlaceList(request: PlaceListRequestDTO)
}

extension PlaceListTargetType: BaseTargetType {
    var path: String {
        switch self {
        case .fetchPlaceList:
            return "/home"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceList:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchPlaceList(let request):
            return .requestJSONEncodable(request)
        }
    }
}
