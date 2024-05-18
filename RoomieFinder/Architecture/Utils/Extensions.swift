//
//  Extensions.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 9/5/24.
//

import Foundation

extension Set where Element == Idiomas {
    func asCommaSeparatedString() -> String {
        return self.map { $0.rawValue }.joined(separator: ", ")
    }
}
