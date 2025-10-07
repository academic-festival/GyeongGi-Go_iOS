//
//  GGFont.swift
//  GG-iOS
//
//  Created by 김승원 on 10/7/25.
//

import SwiftUI

enum GGFont {
    case title01
    case title02
    case title03
    
    case heading01
    case heading02
    case heading03
    case heading04
    
    case body01
    case body02
    
    case label01
    case label02
    case label03
    
    // MARK: - Font Size
    
    private var defaultSize: CGFloat {
        switch self {
        case .title01: return 36
        case .title02: return 28
        case .title03: return 24
        case .heading01: return 20
        case .heading02: return 18
        case .heading03: return 18
        case .heading04: return 16
        case .body01: return 14
        case .body02: return 14
        case .label01: return 12
        case .label02: return 12
        case .label03: return 10
        }
    }
    
    private static let scaleRatio: CGFloat = max(1.adjustedHeight, 1.adjustedWidth)
    
    private var adjustedSize: CGFloat {
        return defaultSize * GGFont.scaleRatio
    }
    
    // MARK: - Letter Spacing
    
    var letterSpacing: CGFloat {
        switch self {
        case .title01, .title02, .title03, .heading01, .heading03:
            return CGFloat(-3) / 100 * adjustedSize
        case .body01, .body02:
            return CGFloat(-2) / 100 * adjustedSize
        case .heading02, .heading04, .label01, .label02:
            return CGFloat(-1) / 100 * adjustedSize
        case .label03:
            return CGFloat(-0) / 100 * adjustedSize
        }
    }
    
    // MARK: - Line Height
    
    var lineHeight: CGFloat {
        switch self {
        case .title01: return 43
        case .title02: return 33
        case .title03: return 29
        case .heading01: return 24
        case .heading02: return 21
        case .heading03: return 25
        case .heading04: return 19
        case .body01: return 17
        case .body02: return 18
        case .label01: return 14
        case .label02: return 14
        case .label03: return 12
        }
    }
    
    // MARK: - Font Weight
    
    private var fontWeight: String {
        switch self {
        case .body01:
            return "Pretendard-Bold"
        case .title01, .title02, .title03, .heading01, .heading02, .heading04, .label01, .label03:
            return "Pretendard-SemiBold"
        case .heading03, .body02, .label02:
            return "Pretendard-Medium"
        }
    }
    
    // MARK: - UIFont Guide
    
    func uiFontGuide() -> UIFont {
        switch self {
        default: return UIFont(name: self.fontWeight, size: self.adjustedSize)!
        }
    }
}

// MARK: - Font Modifier

struct FontWithLineHeight: ViewModifier {
    let uiFont: UIFont
    let targetLineHeight: CGFloat
    let letterSpacing: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(uiFont))
            .lineSpacing(targetLineHeight - uiFont.lineHeight)
            .kerning(letterSpacing)
            .padding(.vertical, (targetLineHeight - uiFont.lineHeight) / 2)
    }
}

extension View {
    func applyGGFont(_ font: GGFont) -> some View {
        modifier(
            FontWithLineHeight(
                uiFont: font.uiFontGuide(),
                targetLineHeight: font.lineHeight,
                letterSpacing: font.letterSpacing
            )
        )
    }
}
