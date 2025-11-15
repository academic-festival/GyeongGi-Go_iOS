//
//  StartChatBotResponseDTO.swift
//  GG-iOS
//
//  Created by 김승원 on 11/15/25.
//

import Foundation

struct StartChatBotResponseDTO: ResponseModelType {
    let answer: String
    let suggestedQuestions: [String]
    let audioData: String
}
