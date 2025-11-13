//
//  PlaceDetailTargetType.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

import Moya

enum PlaceDetailTargetType {
    case fetchPlaceDetail(placeId: Int)
}

extension PlaceDetailTargetType: BaseTargetType {
    var path: String {
        switch self {
        case .fetchPlaceDetail(let placeId):
            return "/places/\(placeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPlaceDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchPlaceDetail:
            return .requestPlain
        }
    }
    
    
}
