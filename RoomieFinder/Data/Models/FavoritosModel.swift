//
//  FavoritosModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 19/5/24.
//

import Foundation

struct Favoritos: Equatable {
    var id: String
    var currentUser: String
    var anuncioID: String

    static func == (lhs: Favoritos, rhs: Favoritos) -> Bool {
        return lhs.currentUser == rhs.currentUser && lhs.anuncioID == rhs.anuncioID
    }
}
