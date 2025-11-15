//
//  LoadingMessageBubble.swift
//  GG-iOS
//
//  Created by 김승원 on 11/15/25.
//

import SwiftUI

struct LoadingMessageBubble: View {
    
    // MARK: - Properties
    
    private let horizontalPadding: CGFloat = 20.adjustedWidth
    private let extraHorizontalPadding: CGFloat = 59.adjustedWidth
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top, spacing: 7.adjustedWidth) {
            Image(.chatbotOrangeIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32.adjusted, height: 32.adjusted)
            
            VStack(alignment: .leading, spacing: 4.adjustedHeight) {
                ProgressView()
                    .scaleEffect(0.8)
                    .padding(.vertical, 10.adjustedHeight)
                    .padding(.horizontal, 12.adjustedWidth)
                    .background(.gray100)
                    .cornerRadius(10, corners: .allCorners)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, horizontalPadding)
        .padding(.trailing, extraHorizontalPadding)
    }
}


#Preview {
    LoadingMessageBubble()
}
