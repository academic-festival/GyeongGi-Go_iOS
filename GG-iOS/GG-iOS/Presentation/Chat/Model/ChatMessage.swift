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


extension ChatMessage {
    static var mockData: [ChatMessage] {
        [
            ChatMessage(sender: .chatBot, message: "From now on, I will give you a brief introduction and information about your surroundings. "),
            ChatMessage(sender: .user, message: "I am curious about Suwon Hwaseong."),
            ChatMessage(sender: .chatBot, message: "Hwaseong Fortress in Suwon is a UNESCO World Heritage site built during the late 18th century by King Jeongjo of the Joseon Dynasty. It was constructed to honor his father and to create a strong, strategic city. The fortress features impressive walls, gates, and military facilities that showcase both Korean and early modern engineering techniques. Today, it is a cultural landmark where visitors can walk along the walls and enjoy panoramic views of the city.")
        ]
    }
}
