//
//  BaseTargetType.swift
//  GG-iOS
//
//  Created by 김승원 on 11/12/25.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        guard let url = URL(string: "\(AppEnvironment.baseURL)") else {
            fatalError("Error: BaseURL을 찾을 수 없습니다.")
        }
        
        return url
    }
    
    var headers: [String: String]? {
        var header = ["Content-Type": "application/json"]
        return header
    }
}
