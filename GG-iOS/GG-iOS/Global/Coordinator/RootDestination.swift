//
//  RootDestination.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

enum RootDestination: Hashable {
    case splash
    case sheet
}

extension RootDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .splash:
            // TODO: - SplashView 연결
            Text("Splash")
        case .sheet:
            MapSheetView()
        }
    }
}
