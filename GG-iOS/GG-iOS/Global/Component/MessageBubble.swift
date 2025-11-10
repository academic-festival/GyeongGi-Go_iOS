//
//  MessageBubble.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

struct MessageBubble: View {
    
    // MARK: - Properties
    
    private let chatMessage: ChatMessage
    
    private let horizontalPadding: CGFloat = 24.adjustedWidth
    private let extraHorizontalPadding: CGFloat = 34.adjustedWidth
    
    // MARK: - Initializer
    
    init(chatMessage: ChatMessage) {
        self.chatMessage = chatMessage
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
                .frame(width: 40.adjusted, height: 40.adjusted)
            
            Text(chatMessage.message)
                .applyGGFont(.body02)
                .foregroundStyle(.textNatural)
                .padding(.vertical, 10.adjustedHeight)
                .padding(.horizontal, 12.adjustedWidth)
                .background(.gray100)
                .cornerRadius(10, corners: .allCorners)
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
}

#Preview {
    MessageBubble(chatMessage: ChatMessage(sender: .chatBot, message: "Hello,This is a place where you can feel the charm of Gyeonggi-do."))
    MessageBubble(chatMessage: ChatMessage(sender: .user, message: "Hello,This is a place where you can feel the charm of Gyeonggi-do."))
}
