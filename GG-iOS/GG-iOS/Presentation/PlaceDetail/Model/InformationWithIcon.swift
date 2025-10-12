//
//  InformationWithIcon.swift
//  GG-iOS
//
//  Created by 김승원 on 10/12/25.
//

import Foundation

struct InformationWithIcon: Identifiable {
    let id = UUID()
    let informationType: InformationType
    let text: String
}
