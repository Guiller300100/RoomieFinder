//
//  MensajesModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class MensajesModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: MensajesModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
