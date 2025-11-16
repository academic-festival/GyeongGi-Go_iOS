//
//  ChatViewModel.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import AVFoundation
import SwiftUI

@MainActor
final class ChatViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published var isChatBotLoading: Bool = true
    @Published var isQuestionLoading: Bool = true
    @Published var chatMessages: [ChatMessage] = []
    @Published var questions: [String] = []
    @Published var playingMessageId: UUID?
    
    private let chatBotService: ChatBotAPI
    
    private var audioPlayer: AVAudioPlayer?
    private let placeId: Int
    let placeName: String
    let address: String
    
    private var suggestedQuestions: [String] = []
    
    // MARK: - Action
    
    enum Action {
        case updateQuestions
        case toggleAudio(chatMessage: ChatMessage)

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
        
        super.init()
        self.configureAudioSession()
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: Action) {
        switch action {
        case .updateQuestions:
            updateRandomQuestions()
            
        case .toggleAudio(let chatMessage):
            toggleAudio(for: chatMessage)
            
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
        
        withAnimation(.easeInOut(duration: 0.2)) {
            chatMessages.append(
                ChatMessage(
                    sender: sender,
                    message: message,
                    audioData: AudioConverter.data(fromBase64: audioString)
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
    
    func toggleAudio(for message: ChatMessage) {
        if playingMessageId == message.id {
            stopAudio()
            return
        }

        guard let data = message.audioData else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            playingMessageId = message.id
            
            print("🎧 오디오 재생 시작 성공 — messageID: \(message.id)")
        } catch {
            print("오디오 재생 실패:", error)
        }
    }
    
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
        playingMessageId = nil
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .spokenAudio,
                options: [.duckOthers]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("오디오 세션 설정 실패:", error)
        }
    }
}

// MARK: - Functions

extension ChatViewModel {
    func isAudioPlaying(messageId: UUID) -> AudioPlayState {
        if messageId == playingMessageId {
            return .playing
        } else {
            return .paused
        }
    }
    
    func audioDuration(for message: ChatMessage) -> TimeInterval {
        guard let data = message.audioData else {
            return 0
        }
        
        do {
            let tempPlayer = try AVAudioPlayer(data: data)
            return tempPlayer.duration
        } catch {
            print("오디오 duration 계산 실패:", error)
            return 0
        }
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

// MARK: -AVAudioPlayerDelegateAVAu

extension ChatViewModel: @MainActor AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if flag {
            print("✅ 오디오 재생 정상 종료 — messageID: \(playingMessageId?.uuidString ?? "nil")")
        } else {
            print("⚠️ 오디오 재생 오류로 종료됨")
        }
        
        playingMessageId = nil
        audioPlayer = nil
    }
}
