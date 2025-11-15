//
//  QuestionRow.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

struct QuestionRow: View {
    
    // MARK: - Properties
    
    private let question: String
    private let onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(question: String, onTap: (() -> Void)? = nil) {
        self.question = question
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            Text(question)
                .applyGGFont(.body02)
                .foregroundStyle(.textNatural)
                .padding(.horizontal, 12.adjustedWidth)
                .frame(height: 50.adjustedHeight)
                .frame(maxWidth: .infinity)
                .addBorder(.roundedRectangle(cornerRadius: 10), borderColor: .gray200, borderWidth: 1)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}

#Preview {
    QuestionRow(question: "Are you curious about Suwon Hwaseong?")
}
