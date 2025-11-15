//
//  ChatView.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

struct ChatView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var viewModel: ChatViewModel
    
    // MARK: - Initializer
    
    init(placeId: Int, placeName: String, address: String) {
        self._viewModel = StateObject(
            wrappedValue: ChatViewModel(
                chatBotService: ChatBotService(),
                placeId: 153,
                placeName: "Suwon Hwaseong1",
                address: "175, Mallijae-ro, Jung-gu, Seoul, Republic of Korea"
            )
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            header
            
            chat
            
            questionList
        }
        .customNavigationBar(.chat(backAction: {
            appCoordinator.goBack()
        }))
        .onAppear {
            viewModel.dispatch(.submitStartChatBot)
        }
    }
}

// MARK: - Subviews

extension ChatView {
    private var header: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 4.adjustedHeight) {
                Text(viewModel.placeName)
                    .applyGGFont(.heading02)
                    .foregroundStyle(.textNatural)
                    .lineLimit(1)
                
                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                    Image(.address12Icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12.adjusted, height: 12.adjusted)
                    
                    Text(viewModel.address)
                        .applyGGFont(.label02)
                        .foregroundStyle(.textLight)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 4.adjustedHeight)
            .padding(.bottom, 12.adjustedHeight)
            .padding(.horizontal, 24.adjustedWidth)
            .background(.gray0)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1.adjustedHeight)
                .foregroundStyle(.gray100)
        }
    }
    
    private var chat: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .center, spacing: 12.adjustedHeight) {
                ForEach(viewModel.chatMessages, id: \.id) { message in
                    MessageBubble(chatMessage: message)
                }
            }
            .padding(.vertical, 28.adjustedHeight)
        }
        .frame(maxWidth: .infinity)
        .background(.gray0)
    }
    
    private var questionList: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1.adjustedHeight)
                .foregroundStyle(.gray100)
            
            VStack(alignment: .center, spacing: 16.adjustedHeight) {
                HStack(alignment: .center, spacing: 0) {
                    Text("Select a suggested question")
                        .applyGGFont(.body02)
                        .foregroundStyle(.mainOrange500)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(.refreshIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24.adjusted, height: 24.adjusted)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 24.adjustedWidth)
                .frame(height: 24.adjustedHeight)
                
                // 임시 질문 list
                VStack(alignment: .center, spacing: 10.adjustedHeight) {
                    QuestionRow(question: "Are you curious about Suwon Hwaseong?")
                    QuestionRow(question: "Are you curious about Suwon Hwaseong?")
                    QuestionRow(question: "Are you curious about Suwon Hwaseong?")
                }
                .padding(.horizontal, 27.adjustedWidth)
            }
        }
    }
}

#Preview {
    ChatView(placeId: 153, placeName: "Example", address: "Example address-123")
        .environmentObject(AppCoordinator())
}
