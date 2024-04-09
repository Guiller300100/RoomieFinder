//
//  CreacionPerfilModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct CreacionPerfilModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: CreacionPerfilModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
