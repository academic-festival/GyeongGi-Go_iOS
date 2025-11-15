//
//  ChatBotTargetType.swift
//  GG-iOS
//
//  Created by 김승원 on 11/15/25.
//

import Foundation

import Moya

enum ChatBotTargetType {
    case submitStartChatBot(request: StartChatBotRequestDTO)
}

extension ChatBotTargetType: BaseTargetType {
    var path: String {
        switch self {
        case .submitStartChatBot:
            return "/chatbot/start"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .submitStartChatBot:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .submitStartChatBot(let request):
            return .requestJSONEncodable(request)
        }
    }
}
