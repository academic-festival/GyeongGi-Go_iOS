//
//  InformationWithIconRow.swift
//  GG-iOS
//
//  Created by 김승원 on 10/12/25.
//

import SwiftUI

struct InformationWithIconRow: View {
    
    // MARK: - Properties
    
    private let information: InformationWithIcon
    
    // MARK: - Initializer
    
    init(_ information: InformationWithIcon) {
        self.information = information
    }
    
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 8.adjustedWidth) {
            icon
            
            text
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Subviews

extension InformationWithIconRow {
    private var icon: some View {
        Image(information.informationType.icon)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 16.adjustedWidth, height: 16.adjustedHeight)
            .padding(.top, 2.adjustedHeight)
    }
    
    private var text: some View {
        Text(information.text)
            .applyGGFont(.body02)
            .foregroundStyle(.textNatural)
            .lineSpacing(4.adjustedHeight)
    }
}

#Preview {
    InformationWithIconRow(
        InformationWithIcon(
            informationType: .address,
            text: "320-2 Hwajeong-dong, Jangan-gu, Suwon-si"
        )
    )
}
