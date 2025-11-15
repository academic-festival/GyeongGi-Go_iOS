//
//  ChatBotService.swift
//  GG-iOS
//
//  Created by 김승원 on 11/15/25.
//

import Foundation

final class ChatBotService: BaseService<ChatBotTargetType> { }

extension ChatBotService: ChatBotAPI {
    func submitStartChatBot(
        request: StartChatBotRequestDTO
    ) async throws -> BaseResponseBody<StartChatBotResponseDTO> {
        return try await self.request(with: .submitStartChatBot(request: request))
    }
    
    func submitRelayChatBot(
        request: RelayChatBotRequestDTO
    ) async throws -> BaseResponseBody<RelayChatBotResponseDTO> {
        return try await self.request(with: .submitRelayChatBot(request: request))
    }
    
}
