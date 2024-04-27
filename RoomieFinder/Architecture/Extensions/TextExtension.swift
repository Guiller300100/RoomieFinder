//
//  TextExtension.swift
//
//  Created on 8/4/24.
//

import Foundation

import SwiftUI

enum CustomFont: String {
    case regularFont = "Outfit"
    case boldFont = "Outfit-Bold"
    case mediumFont = "Outfit-Medium"
}

extension Text {
    func customFont(font: CustomFont? = nil, size: CGFloat, color: Color? = nil) -> Text {
        var text: Text
        
        if let font = font {
            text = self.font(.custom(font.rawValue, size: size))
        } else {
            text = self.font(.system(size: size))
        }
        
        if let color = color {
            text = text.foregroundColor(color)
        }
        
        return text
    }
}
