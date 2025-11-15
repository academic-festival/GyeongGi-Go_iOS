//
//  PlaceDetail.swift
//  GG-iOS
//
//  Created by 김승원 on 11/13/25.
//

import Foundation

struct PlaceDetail {
    let placeId: Int
    let placeName: String
    let imageUrlStrings: [String]
    let address: String
    let inquiry: String
    let price: String?
    let description: String
}

extension PlaceDetail {
    init(from dto: PlaceDetailResponseDTO) {
        self.placeId = dto.placeId
        self.placeName = dto.placeName
        self.imageUrlStrings = dto.placeImages
        self.address = dto.address
        self.inquiry = dto.inquiry
        self.price = dto.price
        self.description = dto.locationExplain
    }
}

extension PlaceDetail {
    static var mockData: PlaceDetail {
        return PlaceDetail(
            placeId: 1,
            placeName: "Suwon Hwaseong1",
            imageUrlStrings: TempImageUrlString.threeImageUrlStrings(),
            address: "320-2 Hwajeong-dong, Jangan-gu, Suwon-si",
            inquiry: "www.nye020308.co.kr",
            price: "Infant : free\nChildren : 3000\nAdult : 7000",
            description: "The name was changed to Suwon Dohobu (護府) in the 17th year of King Jeongjo's reign (1793). It also refers to the fortress built here. In 1789, King Jeongjo moved the 園 of Crown Prince Jangheon (莊獻), his birth The name was changed to Suwon Dohobu (護府) in the 17th year of King Jeongjo's reign (1793). It also refers to the fortress built here. In 1789, King Jeongjo moved the 園 of Crown Prince Jangheon (莊獻), his birth."
        )
    }
}

extension PlaceDetail {
    static var skeletonData: PlaceDetail {
        return PlaceDetail(
            placeId: 1,
            placeName: "",
            imageUrlStrings: ["1", "2", "3"],
            address: "",
            inquiry: "",
            price: "",
            description: ""
        )
    }
}
