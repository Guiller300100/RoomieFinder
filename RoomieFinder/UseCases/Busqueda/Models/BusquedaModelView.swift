//
//  BusquedaModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct BusquedaModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: BusquedaModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
