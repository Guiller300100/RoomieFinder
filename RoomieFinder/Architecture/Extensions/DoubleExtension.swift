//
//  DoubleExtension.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 22/5/24.
//

import Foundation

extension Double {
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
