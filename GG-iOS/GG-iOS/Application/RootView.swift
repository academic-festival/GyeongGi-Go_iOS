//
//  RootView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/1/25.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
//            appCoordinator.root.build()
            ChatView(
                placeId: 153,
                placeName: "Example",
                address: "320-2 Example-dong, Jangan-gu, Suwon-si"
            )
//                .navigationDestination(for: AppDestination.self) { $0.build() }
                .navigationBarHidden(true)
        }
        .environmentObject(appCoordinator)
    }
}

#Preview {
    RootView()
}
