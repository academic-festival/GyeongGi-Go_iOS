//
//  PlaceDetailView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceDetailView: View {
    
    // MARK: - Propertiew
    
    // MARK: - Initializer
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 0) {
                header
                    .padding(.bottom, 16.adjustedHeight)
                
                details
                    .padding(.bottom, 24.adjustedHeight)
                
                divider
                    .padding(.bottom, 24.adjustedHeight)
                
                description
                
                scrollSpacer
            }
        }
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    private var header: some View {
        PlaceCuratorHeader() {
            // TODO: - 큐레이터 연결
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 20.adjustedHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var details: some View {
        VStack(alignment: .center, spacing: 20.adjustedHeight) {
            title
            
            photos
            
            informations
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var title: some View {
        Text("Suwon Hwaseong")
            .applyGGFont(.title02)
            .foregroundStyle(.textNatural)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
    }
    
    private var photos: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            Image(.temp)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(.gray300)
                .frame(width: 218.adjustedWidth)
                .cornerRadius(10, corners: .allCorners)
            
            VStack(alignment: .center, spacing: 8.adjustedHeight) {
                Image(.temp)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(.gray300)
                    .cornerRadius(10, corners: .allCorners)
                
                Image(.temp)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(.gray300)
                    .cornerRadius(10, corners: .allCorners)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 168.adjustedHeight)
    }
    
    private var informations: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            InformationWithIconRow(
                InformationWithIcon(
                    informationType: .address,
                    text: "320-2 Hwajeong-dong, Jangan-gu, Suwon-si"
                )
            )
            
            InformationWithIconRow(
                InformationWithIcon(
                    informationType: .url,
                    text: "www.nye020308.co.kr"
                )
            )
            
            InformationWithIconRow(
                InformationWithIcon(
                    informationType: .price,
                    text: "Infant : free\nChildren : 3000\nAdult : 7000"
                )
            )
        }
    }
    
    private var divider: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 6.adjustedHeight)
            .foregroundStyle(.gray100)
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            Text("Description")
                .applyGGFont(.heading02)
                .foregroundStyle(.textNatural)
            
            Text("The name was changed to Suwon Dohobu (護府) in the 17th year of King Jeongjo's reign (1793). It also refers to the fortress built here. In 1789, King Jeongjo moved the 園 of Crown Prince Jangheon (莊獻), his birth The name was changed to Suwon Dohobu (護府) in the 17th year of King Jeongjo's reign (1793). It also refers to the fortress built here. In 1789, King Jeongjo moved the 園 of Crown Prince Jangheon (莊獻), his birth,")
                .applyGGFont(.body02)
                .foregroundStyle(.textNormal)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var scrollSpacer: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 100.adjustedHeight)
            .foregroundStyle(.clear)
    }
}

#Preview {
    PlaceDetailView()
}
