//
//  PlaceDetailView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceDetailView: View {
    var onTap: (() -> Void)?
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            Text("PlaceDetailView")
        }
    }
}

#Preview {
    PlaceDetailView()
}
