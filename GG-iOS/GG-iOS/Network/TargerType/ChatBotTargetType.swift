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
    case submitRelayChatBot(request: RelayChatBotRequestDTO)
}

extension ChatBotTargetType: BaseTargetType {
    var path: String {
        switch self {
        case .submitStartChatBot:
            return "/chatbot/start"
        case .submitRelayChatBot:
            return "/chatBot/relay"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .submitStartChatBot:
            return .post
        case .submitRelayChatBot:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .submitStartChatBot(let request):
            return .requestJSONEncodable(request)
        case .submitRelayChatBot(let request):
            return .requestJSONEncodable(request)
        }
    }
}
