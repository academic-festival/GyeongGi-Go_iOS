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
            appCoordinator.root.build()
                .navigationDestination(for: AppDestination.self) { $0.build() }
                .navigationBarHidden(true)
        }
        .environmentObject(appCoordinator)
    }
}

#Preview {
    RootView()
}
