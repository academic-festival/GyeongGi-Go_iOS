//
//  ChatBotAPI.swift
//  GG-iOS
//
//  Created by 김승원 on 11/15/25.
//

import Foundation

protocol ChatBotAPI {
    /// 챗봇 대화 시작
    func submitStartChatBot(
        request: StartChatBotRequestDTO
    ) async throws -> BaseResponseBody<StartChatBotResponseDTO>
}
