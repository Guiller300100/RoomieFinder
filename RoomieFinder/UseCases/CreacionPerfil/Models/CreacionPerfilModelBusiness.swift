//
//  CreacionPerfilModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class CreacionPerfilModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: CreacionPerfilModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
