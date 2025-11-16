//
//  MessageBubble.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

struct MessageBubble: View {
    
    // MARK: - Properties
    
    @State private var progress: CGFloat = 0
    @State private var animationID = UUID()
    
    private let chatMessage: ChatMessage
    private let audioPlayState: AudioPlayState
    private let duration: TimeInterval
    private let onTap: (() -> Void)?
    
    private let horizontalPadding: CGFloat = 20.adjustedWidth
    private let extraHorizontalPadding: CGFloat = 59.adjustedWidth
    
    // MARK: - Initializer
    
    init(
        chatMessage: ChatMessage,
        audioPlayState: AudioPlayState,
        duration: TimeInterval,
        onTap: (() -> Void)? = nil
    ) {
        self.chatMessage = chatMessage
        self.audioPlayState = audioPlayState
        self.duration = duration
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        switch chatMessage.sender {
        case .chatBot:
            chatBotMessageBubble
        case .user:
            userMessageBubble
        }
    }
}

// MARK: - Subviews

extension MessageBubble {
    private var chatBotMessageBubble: some View {
        HStack(alignment: .top, spacing: 7.adjustedWidth) {
            Image(.chatbotOrangeIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32.adjusted, height: 32.adjusted)
            
            VStack(alignment: .leading, spacing: 4.adjustedHeight) {
                Text(chatMessage.message)
                    .applyGGFont(.body02)
                    .foregroundStyle(.textNatural)
                    .padding(.vertical, 10.adjustedHeight)
                    .padding(.horizontal, 12.adjustedWidth)
                    .background(.gray100)
                    .cornerRadius(10, corners: .allCorners)
                
                if chatMessage.audioData != nil {
                    audioSlider
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, horizontalPadding)
        .padding(.trailing, extraHorizontalPadding)
    }
    
    private var userMessageBubble: some View {
        Text(chatMessage.message)
            .applyGGFont(.body02)
            .foregroundStyle(.textNatural)
            .padding(.vertical, 10.adjustedHeight)
            .padding(.horizontal, 12.adjustedWidth)
            .background(.gray0)
            .cornerRadius(10, corners: .allCorners)
            .addBorder(.roundedRectangle(cornerRadius: 10), borderColor: .gray100, borderWidth: 1)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, horizontalPadding)
            .padding(.leading, extraHorizontalPadding)
    }
    
    private var audioSlider: some View {
        HStack(alignment: .center, spacing: 12.adjustedWidth) {
            Button {
                onTap?()
            } label: {
                Image(audioPlayState.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16.adjusted, height: 16.adjusted)
            }
            .buttonStyle(.plain)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: 100.adjustedWidth, height: 4.adjustedHeight)
                    .foregroundStyle(.gray0)
                
                Capsule()
                    .frame(width: (100.adjustedWidth * progress), height: 4.adjustedHeight)
                    .foregroundStyle(.mainOrange500)
            }
            .padding(.trailing, 4.adjustedWidth)
        }
        .padding(.vertical, 10.adjustedHeight)
        .padding(.horizontal, 12.adjustedWidth)
        .background(.gray100)
        .cornerRadius(10, corners: .allCorners)
        .id(animationID)
        .onChange(of: audioPlayState) { _, newValue in
            handleAudioStateChange(newValue)
        }
    }
}

// MARK: - Functions

extension MessageBubble {
    private func startProgressAnimation() {
        progress = 0
        
        withAnimation(.linear(duration: duration)) {
            progress = 1
        }
    }

    private func resetProgressAnimation() {
        progress = 0
        animationID = UUID()
    }
    
    private func handleAudioStateChange(_ state: AudioPlayState) {
        switch state {
        case .playing:
            startProgressAnimation()
        case .paused:
            resetProgressAnimation()
        }
    }
}
