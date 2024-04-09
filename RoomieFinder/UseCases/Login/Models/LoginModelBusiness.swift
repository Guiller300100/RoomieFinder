//
//  LoginModelBusiness.swift
//
//  Created on 9/4/24
//

import Foundation

class LoginModelBusiness {
    // Define properties
    var property: String = ""
    
    init(modelServer: LoginModelServer?) {
        guard let model = modelServer else {
            return
        }
        
        // Set values
        self.property = model.property ?? ""
    }
}
