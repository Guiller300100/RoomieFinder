//
//  PerfilModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 21/3/24.

import Foundation
import SwiftUI

struct Usuario: Identifiable {
    var id: String
    var userID: String
    var nombre: String
    var apellido: String
    var fnac: String
    var info: Info
}


struct Info {
    var estudios: String
    var universidad: String
    var idiomas: Set<Idiomas>
    var sexo: String
    var tipoPersona: String
    var ambiente: String
    var tiempoLibre: String
    var fumar: Bool
    var fiesta: Bool
    var descripcion: String
    var urlImage: String
}
