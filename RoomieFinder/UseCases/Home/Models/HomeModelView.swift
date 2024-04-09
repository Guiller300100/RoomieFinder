//
//  HomeModelView.swift
//
//  Created on 9/4/24
//

import Foundation

struct HomeModelView {
    // Define properties
    let property: String
    
    init(modelBusiness: HomeModelBusiness?) {
        guard let model = modelBusiness else {
            self.property = ""
            return
        }

        // Set values
        self.property = model.property
    }
}
