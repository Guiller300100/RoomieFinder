//
//  RootViewCoordinator.swift
//  MyEdex
//
//  Created by Raul Pascual de la Calle on 8/4/24.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewRouter: RootViewCoordinator
    
    var body: some View {
        getRootView(module: viewRouter.selectedModule)
    }
    
    @ViewBuilder func getRootView(module: AppModule) -> some View {
        switch module {
        case .splash:
            EmptyView()
            
        case .main:
            LoginView(LoginViewModel())

        case .login:
            EmptyView()
        }
    }
}

class RootViewCoordinator: ObservableObject {
    static let shared = RootViewCoordinator()
    
    @Published var selectedModule = AppModule.main
    
    func setModule(_ module: AppModule, animation: Animation? = .easeInOut(duration: 0.3)) {
        withAnimation(animation) {
            selectedModule = module
        }
    }
}

public enum AppModule {
    case splash
    case main
    case login
}
