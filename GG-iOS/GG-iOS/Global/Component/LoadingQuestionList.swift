//
//  LoadingQuestionList.swift
//  GG-iOS
//
//  Created by 김승원 on 11/15/25.
//

import SwiftUI

struct LoadingQuestionList: View {
    
    // MARK: - Properties
    
    private let count: Int
    
    // MARK: - Initializer
    
    init(count: Int = 3) {
        self.count = count
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 10.adjustedHeight) {
            ForEach(0..<count, id: \.self) { _ in
                ProgressView()
                    .scaleEffect(0.8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.adjustedHeight)
                    .addBorder(.roundedRectangle(cornerRadius: 10), borderColor: .gray200, borderWidth: 1)
            }
        }
        .disabled(true)
    }
}

#Preview {
    LoadingQuestionList()
}
