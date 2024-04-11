//
//  MensajesModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct MensajesModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: MensajesModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}