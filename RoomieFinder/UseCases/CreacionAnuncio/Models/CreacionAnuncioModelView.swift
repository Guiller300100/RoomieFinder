//
//  CreacionAnuncioModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct CreacionAnuncioModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: CreacionAnuncioModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
