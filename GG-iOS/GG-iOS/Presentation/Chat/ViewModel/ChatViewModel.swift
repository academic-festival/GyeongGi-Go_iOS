//
//  ChatViewModel.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

@MainActor
final class ChatViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isLoading: Bool = true
    @Published var chatMessages: [ChatMessage] = ChatMessage.mockData
    
    private let chatBotService: ChatBotAPI
    
    private let placeId: Int
    let placeName: String
    let address: String
    
    // MARK: - Action
    
    enum Action {

        // api
        case submitStartChatBot
    }
    
    // MARK: - Initializer
    
    init(
        chatBotService: ChatBotAPI,
        placeId: Int,
        placeName: String,
        address: String
    ) {
        self.chatBotService = chatBotService
        self.placeId = placeId
        self.placeName = placeName
        self.address = address
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: Action) {
        switch action {
        case .submitStartChatBot:
            isLoading = true
            
            Task {
                await submitStartChatBot(
                    request: StartChatBotRequestDTO(
                        placeId: placeId
                    )
                )
            }
        }
    }
}

// MARK: - API

private extension ChatViewModel {
    func submitStartChatBot(request: StartChatBotRequestDTO) async {
        do {
            let response = try await chatBotService.submitStartChatBot(request: request)
            
            guard let data = response.data else { return }
            
        } catch let error as NetworkError {
            
        } catch {
            
        }
    }
}
