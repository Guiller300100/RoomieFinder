//
//  AnuncioModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 15/5/24.
//

import Foundation
import SwiftUI

struct Anuncio: Identifiable {
    var id: String
    var userID: String
    var barrio: String
    var tiempoEstancia: String
    var presupuesto: String
    var num_hab: String
}
