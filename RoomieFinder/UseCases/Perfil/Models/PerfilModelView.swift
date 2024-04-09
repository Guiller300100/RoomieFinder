//
//  PerfilModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct PerfilModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: PerfilModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
