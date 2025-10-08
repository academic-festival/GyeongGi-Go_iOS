//
//  AppDestination.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

enum AppDestination: Hashable {
    case temp
}

extension AppDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .temp:
            Text("Temp View")
        }
    }
}
