//
//  PersonasModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct PersonasModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: PersonasModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
