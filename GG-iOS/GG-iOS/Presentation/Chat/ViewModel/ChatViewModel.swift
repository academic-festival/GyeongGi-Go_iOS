//
//  ChatViewModel.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var placeName: String = ""
    @Published var address: String = ""
    @Published var chatMessages: [ChatMessage] = ChatMessage.mockData
    
    // MARK: - Action

}
