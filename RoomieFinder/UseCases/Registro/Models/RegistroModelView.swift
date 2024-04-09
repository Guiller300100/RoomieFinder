//
//  RegistroModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct RegistroModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: RegistroModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
