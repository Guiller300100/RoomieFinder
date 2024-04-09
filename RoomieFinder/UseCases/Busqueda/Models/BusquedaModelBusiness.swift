//
//  BusquedaModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class BusquedaModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: BusquedaModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
