//
//  AppCoordinator.swift
//  GG-iOS
//
//  Created by 김승원 on 10/9/25.
//

import Foundation

final class AppCoordinator: ObservableObject {
    
    // MARK: - Properties
    
    @Published var path: [AppDestination] = []
    @Published var root: RootDestination = .sheet
    @Published var sheetState: SheetState = .list
    
    // MARK: - Functions
    
    func navigate(to destination: AppDestination) {
        path.append(destination)
    }
    
    func goBack() {
        _ = path.popLast()
    }
    
    func goToRoot() {
        path.removeAll()
    }
    
    func switchTab(to sheetState: SheetState) {
        self.sheetState = sheetState
    }
    
    func changeRoot(to root: RootDestination) {
        path.removeAll()
        self.root = root
    }
}
