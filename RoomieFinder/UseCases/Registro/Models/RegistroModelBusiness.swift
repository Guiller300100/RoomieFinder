//
//  RegistroModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class RegistroModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: RegistroModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
