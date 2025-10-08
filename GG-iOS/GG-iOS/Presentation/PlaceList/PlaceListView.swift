//
//  PlaceListView.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import SwiftUI

struct PlaceListView: View {
    var onTap: (() -> Void)?
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            Text("PlaceListView")
        }
    }
}

#Preview {
    PlaceListView()
}
