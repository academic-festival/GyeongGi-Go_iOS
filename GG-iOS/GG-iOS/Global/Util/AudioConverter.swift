//
//  AudioConverter.swift
//  GG-iOS
//
//  Created by 김승원 on 11/16/25.
//

import Foundation

enum AudioConverter {
    /// Base64 문자열을 Data로 변환합니다.
        static func data(fromBase64 string: String?) -> Data? {
            guard let string else { return nil }
            return Data(base64Encoded: string)
        }
}
