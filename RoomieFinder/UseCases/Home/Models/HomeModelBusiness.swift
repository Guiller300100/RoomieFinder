//
//  HomeModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class HomeModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: HomeModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
