//
//  PisosModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class PisosModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: PisosModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
