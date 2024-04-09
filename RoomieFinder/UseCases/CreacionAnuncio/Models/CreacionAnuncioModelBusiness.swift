//
//  CreacionAnuncioModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class CreacionAnuncioModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: CreacionAnuncioModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
