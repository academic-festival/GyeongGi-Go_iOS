//
//  RelayChatBotRequestDTO.swift
//  GG-iOS
//
//  Created by 김승원 on 11/15/25.
//

import Foundation

struct RelayChatBotRequestDTO: RequestModelType {
    let placeId: Int
    let question: String
}
