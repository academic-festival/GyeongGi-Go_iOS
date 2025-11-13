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
            fatalError("BaseURL을 찾을 수 없습니다.")
        }
        
        return url
    }
    
    var headers: [String: String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
}
