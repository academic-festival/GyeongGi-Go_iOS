//
//  SheetState.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import Foundation

enum SheetState: CaseIterable, Hashable {
    case list
    case detail
    
    static var defaultHeight: CGFloat {
        return 400.adjustedHeight
    }
    
    static var minimumHeight: CGFloat {
        return 110.adjustedHeight
    }
    
    static var maximumHeight: CGFloat {
        return 692.adjustedHeight
    }
}
