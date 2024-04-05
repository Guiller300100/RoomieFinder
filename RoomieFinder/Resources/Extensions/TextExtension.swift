//
//  TextExtension.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 5/4/24.
//

import SwiftUI

enum CustomFont: String {
    case regularFont = "Outfit"
    case boldFont = "Outfit-Bold"
    case mediumFont = "Outfit-Medium"
}

extension Text {

    func customFont(_ font: CustomFont, size: CGFloat, color: Color? = nil) -> Text {
        
        var text = self.font(.custom(font.rawValue, size: size))

        if let colorDes = color {
            text = text.foregroundColor(colorDes)
        }

        return text
    }
}
