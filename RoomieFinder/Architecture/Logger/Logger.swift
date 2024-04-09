//
//  Logger.swift
//  MyEdex
//
//  Created by Raul Pascual de la Calle on 9/4/24.
//

import Foundation

enum Logger {
    // swiftlint:disable disable_print
    static func log(_ items: Any...) {
 // #if DEV || PRE
        print(items)
 // #endif
    }
    // swiftlint:enable disable_print
}
