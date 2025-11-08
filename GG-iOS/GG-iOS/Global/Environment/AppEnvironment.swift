//
//  AppEnvironment.swift
//  GG-iOS
//
//  Created by 김승원 on 11/8/25.
//

import Foundation

enum AppEnvironment {
    /// BaseURL
    static let baseURL: String = {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("Info.plist에 Base_URL이 없습니다.")
        }
        
        return baseURL
    }()
}
