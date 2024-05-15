//
//  HomeViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import SwiftUI


public class HomeViewModel: ObservableObject {

    //ARRAYS DE DATOS
//    @ObservedObject var globalViewModel = GlobalViewModel.shared


    public func onAppear() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Constants.mainColor) // Cambia el color de los TabItems no seleccionados
        FirestoreUtils.getAllData { success in
            if success {
                print("Se han recogido todos los datos")
            } else {
                print("error al recoger los datos")
            }
        }
    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

struct HomeDTO {
    // Añadir propiedades del DTO si fuese necesario
}
