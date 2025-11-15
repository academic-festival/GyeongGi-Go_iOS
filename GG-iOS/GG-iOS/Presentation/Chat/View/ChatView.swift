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
                address: "175, Mallijae-ro, Jung-gu, Seoul, Republic of Korea1"
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
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                LazyVStack(alignment: .center, spacing: 12.adjustedHeight) {
                    ForEach(viewModel.chatMessages, id: \.id) { message in
                        MessageBubble(chatMessage: message)
                    }
                    
                    if viewModel.isChatBotLoading {
                        LoadingMessageBubble()
                    }
                    
                    Rectangle()
                        .foregroundStyle(.gray0)
                        .frame(maxWidth: .infinity)
                        .frame(height: 28.adjustedHeight)
                        .id("scrollToBottom")
                }
                .padding(.top, 28.adjustedHeight)
            }
            .onChange(of: viewModel.chatMessages.count) { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeOut(duration: 0.25)) {
                        proxy.scrollTo("scrollToBottom", anchor: .bottom)
                    }
                }
            }


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
                        withAnimation(nil) {
                            viewModel.dispatch(.updateQuestions)
                        }
                    } label: {
                        Image(.refreshIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24.adjusted, height: 24.adjusted)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                    .disabled(viewModel.isChatBotLoading)
                }
                .padding(.horizontal, 24.adjustedWidth)
                .frame(height: 24.adjustedHeight)
                
                LazyVStack(alignment: .center, spacing: 10.adjustedHeight) {
                    ForEach(viewModel.questions, id: \.self) { question in
                        QuestionRow(question: question) {
                            viewModel.dispatch(.submitRelayChatBot(question: question))
                        }
                    }
                }
                .disabled(viewModel.isChatBotLoading)
                .padding(.horizontal, 27.adjustedWidth)
            }
        }
    }
}

#Preview {
    ChatView(placeId: 153, placeName: "Example", address: "Example address-123")
        .environmentObject(AppCoordinator())
}
