//
//  CustomNavigationBarModifier.swift
//  GG-iOS
//
//  Created by 김승원 on 11/10/25.
//

import SwiftUI

struct CustomNavigationBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    let centerView: (() -> C)?
    let leftView: (() -> L)?
    let rightView: (() -> R)?
    let backgroundColor: Color
    
    init(
        centerView: (() -> C)? = nil,
        leftView: (() -> L)? = nil,
        rightView: (() -> R)? = nil,
        backgroundColor: Color
    ) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                HStack(spacing: 0) {
                    self.leftView?()
                    
                    Spacer()
                    
                    self.rightView?()
                }
                
                self.centerView?()
                
            }
            .padding(.horizontal, 20.adjustedWidth)
            .frame(height: 60.adjustedHeight)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            
            content
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

extension View {
    @ViewBuilder
    func customNavigationBar(_ navigationBarType: NavigationBarType) -> some View {
        switch navigationBarType {
        case .chat(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        EmptyView()
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.arrowLeftIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .gray0
                )
            )
        }
    }
}
