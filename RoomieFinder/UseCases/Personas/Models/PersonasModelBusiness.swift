//
//  PersonasModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class PersonasModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: PersonasModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
