//
//  UserMarker.swift
//  GG-iOS
//
//  Created by 김승원 on 11/16/25.
//

import SwiftUI

struct UserMarker: View {
    
    // MARK: - Body
    
    var body: some View {
        Image(.userLocationIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 28.adjusted, height: 28.adjusted)
            .shadow(radius: 4)
    }
}

#Preview {
    UserMarker()
}
