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
    
    @Published var isChatBotLoading: Bool = true
    @Published var isQuestionLoading: Bool = true
    @Published var chatMessages: [ChatMessage] = []
    @Published var questions: [String] = []
    
    private let chatBotService: ChatBotAPI
    
    private let placeId: Int
    let placeName: String
    let address: String
    
    private var suggestedQuestions: [String] = []
    
    // MARK: - Action
    
    enum Action {
        case updateQuestions

        // api
        case submitStartChatBot
        case submitRelayChatBot(question: String)
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
        case .updateQuestions:
            updateRandomQuestions()
            
        case .submitStartChatBot:
            isChatBotLoading = true
            isQuestionLoading = true
            
            Task {
                await submitStartChatBot(
                    request: StartChatBotRequestDTO(
                        placeId: placeId
                    )
                )
            }
            
        case .submitRelayChatBot(let question):
            isChatBotLoading = true
            
            appendChatMessage(
                sender: .user,
                message: question,
                audioString: nil
            )
            
            Task {
                await submitRelayChatBot(
                    request: RelayChatBotRequestDTO(
                        placeId: placeId,
                        question: question
                    )
                )
            }
            
        }
    }
}

// MARK: - Private Functions

private extension ChatViewModel {
    func appendChatMessage(
        sender: Sender,
        message: String,
        audioString: String?
    ) {
        // TODO: - AudioString -> AudioData 변환 필요
        
        withAnimation(.easeInOut(duration: 0.2)) {
            chatMessages.append(
                ChatMessage(
                    sender: sender,
                    message: message,
                    audioData: nil // 임시 nil
                )
            )
        }
    }
    
    func updateRandomQuestions() {
        let filtered = suggestedQuestions.filter { !questions.contains($0) }
        
        let newQuestions: [String]
        if filtered.count < 3 {
            newQuestions = Array(suggestedQuestions.shuffled().prefix(3))
        } else {
            newQuestions = Array(filtered.shuffled().prefix(3))
        }
        
        withAnimation(.easeInOut(duration: 0.2)) {
            questions = newQuestions
        }
        
        isQuestionLoading = false
    }

}

// MARK: - API

private extension ChatViewModel {
    func submitStartChatBot(request: StartChatBotRequestDTO) async {
        do {
            let response = try await chatBotService.submitStartChatBot(request: request)
            
            guard let data = response.data else { return }
            
            isChatBotLoading = false
            suggestedQuestions = data.suggestedQuestions
            updateRandomQuestions()
            appendChatMessage(
                sender: .chatBot,
                message: data.answer,
                audioString: data.audioData
            )
            
        } catch let error as NetworkError {
            print(error)
        } catch {
            print(NetworkError.unknownError)
        }
    }
    
    func submitRelayChatBot(request: RelayChatBotRequestDTO) async {
        do {
            let response = try await chatBotService.submitRelayChatBot(request: request)
            
            guard let data = response.data else { return }
            
            isChatBotLoading = false
            appendChatMessage(
                sender: .chatBot,
                message: data.answer,
                audioString: data.audioData
            )
            updateRandomQuestions()
            
        } catch let error as NetworkError {
            print(error)
        } catch {
            print(NetworkError.unknownError)
        }
    }
}
