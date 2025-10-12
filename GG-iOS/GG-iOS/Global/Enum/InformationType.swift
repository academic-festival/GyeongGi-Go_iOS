//
//  InformationType.swift
//  GG-iOS
//
//  Created by 김승원 on 10/12/25.
//

import SwiftUI

enum InformationType {
    case address
    case url
    case price
    
    var icon: ImageResource {
        switch self {
        case .address: return .address16Icon
        case .url: return .megaphoneIcon
        case .price: return .ticketIcon
        }
    }
}
