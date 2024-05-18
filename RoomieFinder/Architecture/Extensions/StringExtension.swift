//
//  StringExtension.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 9/4/24.
//

import Foundation


extension String {
    public func isEmailValid() -> Bool {
        guard !isEmpty else {
            return false
        }
        
        let regTest = NSPredicate(format: "SELF MATCHES %@", "[\\w.\\-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return regTest.evaluate(with: self)
    }
}
