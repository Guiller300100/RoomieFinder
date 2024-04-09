//
//  PerfilModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class PerfilModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: PerfilModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
