//
//  RootDestination.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

enum RootDestination: Hashable {
    case sheet
}

extension RootDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .sheet:
            MapSheetView()
        }
    }
}
