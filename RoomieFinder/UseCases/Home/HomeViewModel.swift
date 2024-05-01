//
//  HomeViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import UIKit

public class HomeViewModel: ObservableObject {
    
    public func onAppear() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Constants.mainColor) // Cambia el color de los TabItems no seleccionados
    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

struct HomeDTO {
    // Añadir propiedades del DTO si fuese necesario
}
