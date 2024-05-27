//
//  Constants.swift
//
//  Created on 8/4/24.
//

import Foundation
import SwiftUI

struct Constants {

    //MARK: - Strings
    static let titulo = "RoomieFinder"

    //MARK: - Colores
    static let mainColor = Color("AccentColor")
    static let secondaryColor = Color("SecondColor")
    static let textFieldColor = Color("TextFieldColor")
    static let inicioSesionColor = Color("inicioSesionColor")
    static let RegistroColor = Color("RegistroColor")

    public enum Firebase {
        static let fromId = "fromId"
        static let toId = "toId"
        static let text = "text"
        static let timestamp = "timestamp"
    }
}


public enum CollectionType: String {
    case Perfiles
    case Anuncios
    case Favoritos
}
