//
//  BaseResponseBody.swift
//  GG-iOS
//
//  Created by 김승원 on 11/8/25.
//

import Foundation

struct BaseResponseBody<T: ResponseModelType>: ResponseModelType {
    let code: Int
    let message: String
    let data: T?
}
