//
//  ChatMessage.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let sender: Sender
    let message: String
    let audioData: Data?
}

enum Sender {
    case chatBot
    case user
}

enum AudioPlayState {
    case playing
    case paused
    
    var icon: ImageResource {
        switch self {
        case .playing:
            return .pauseIcon
        case .paused:
            return .playIcon
        }
    }
}


extension ChatMessage {
    static var mockData: [ChatMessage] {
        [
            ChatMessage(sender: .chatBot, message: "From now on, I will give you a brief introduction and information about your surroundings. ", audioData: nil),
            ChatMessage(sender: .user, message: "I am curious about Suwon Hwaseong.", audioData: nil),
            ChatMessage(sender: .chatBot, message: "I am curious about Suwon Hwaseong.", audioData: Data()),
            ChatMessage(sender: .user, message: "I am curious about Suwon Hwaseong.", audioData: nil),
            ChatMessage(
                sender: .chatBot,
                message: "Hwaseong Fortress in Suwon is a UNESCO World Heritage site built during the late 18th century by King Jeongjo of the Joseon Dynasty. It was constructed to honor his father and to create a strong, strategic city. The fortress features impressive walls, gates, and military facilities that showcase both Korean and early modern engineering techniques. Today, it is a cultural landmark where visitors can walk along the walls and enjoy panoramic views of the city.",
                audioData: AudioConverter.data(fromBase64: "UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQAAAAA=")
            )
        ]
    }
}
