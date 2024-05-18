//
//  HomeViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import SwiftUI
import Firebase


public class HomeViewModel: ObservableObject {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared


    @Published var selection: Int = 3

    public func onAppear() {
        if globalViewModel.fromLogin {
            selection = 1
            globalViewModel.fromLogin = false
        }
        UITabBar.appearance().unselectedItemTintColor = UIColor(Constants.mainColor)
    }



    public func actionFromView() {
        // Example of private method
    }

}

struct HomeDTO {
    // Añadir propiedades del DTO si fuese necesario
}
