//
//  ChatMessage.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let sender: Sender
    let message: String
}

enum Sender {
    case chatBot
    case user
}
