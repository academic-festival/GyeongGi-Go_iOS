//
//  AudioConverter.swift
//  GG-iOS
//
//  Created by 김승원 on 11/16/25.
//

import Foundation

enum AudioConverter {
    static func data(fromBase64 string: String?) -> Data? {
        guard let string = string else {
            print("⚠️ Base64 string is nil")
            return nil
        }
        
        guard let data = Data(base64Encoded: string) else {
            print("⚠️ Failed to decode Base64 string (length: \(string.count))")
            return nil
        }
        
        print("✅ Successfully decoded audio data: \(data.count) bytes")
        return data
    }
}
