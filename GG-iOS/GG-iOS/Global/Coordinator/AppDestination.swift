//
//  AppDestination.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

enum AppDestination: Hashable {
    case chat
}

extension AppDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .chat:
            ChatView()
        }
    }
}
