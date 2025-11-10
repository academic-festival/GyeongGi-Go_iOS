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
    @StateObject private var viewModel = ChatViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            header
            
            Spacer()
            
            questionList
        }
        .customNavigationBar(.chat(backAction: {
            appCoordinator.goBack()
        }))
    }
}

// MARK: - Subviews

extension ChatView {
    private var header: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 4.adjustedHeight) {
                Text("Suwon Hwaseong")
                    .applyGGFont(.heading02)
                    .foregroundStyle(.textNatural)
                    .lineLimit(1)
                
                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                    Image(.address12Icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12.adjusted, height: 12.adjusted)
                    
                    Text("320-2 Hwajeong-dong, Jangan-gu, Suwon-si")
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
    ChatView()
        .environmentObject(AppCoordinator())
}
