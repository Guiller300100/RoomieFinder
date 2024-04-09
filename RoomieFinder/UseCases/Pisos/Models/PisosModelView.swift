//
//  PisosModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct PisosModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: PisosModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
