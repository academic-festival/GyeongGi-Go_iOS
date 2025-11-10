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
    
    // MARK: - Body
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .customNavigationBar(.chat(backAction: {
                appCoordinator.goBack()
            })
        )
    }
}

#Preview {
    ChatView()
        .environmentObject(AppCoordinator())
}
