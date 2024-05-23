//
//  PerfilModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 21/3/24.

import Foundation
import SwiftUI

struct Usuario: Identifiable, Equatable {
    var id: String
    var userID: String
    var nombre: String
    var apellido: String
    var fnac: String
    var info: Info

    static func ==(lhs: Usuario, rhs: Usuario) -> Bool {
            return lhs.id == rhs.id
                && lhs.userID == rhs.userID
                && lhs.nombre == rhs.nombre
                && lhs.apellido == rhs.apellido
                && lhs.fnac == rhs.fnac
                && lhs.info == rhs.info
        }
}


struct Info: Equatable {
    var estudios: String
    var trabaja: Bool
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

    static func ==(lhs: Info, rhs: Info) -> Bool {
            return lhs.estudios == rhs.estudios
                && lhs.trabaja == rhs.trabaja
                && lhs.universidad == rhs.universidad
                && lhs.idiomas == rhs.idiomas
                && lhs.sexo == rhs.sexo
                && lhs.tipoPersona == rhs.tipoPersona
                && lhs.ambiente == rhs.ambiente
                && lhs.tiempoLibre == rhs.tiempoLibre
                && lhs.fumar == rhs.fumar
                && lhs.fiesta == rhs.fiesta
                && lhs.descripcion == rhs.descripcion
                && lhs.urlImage == rhs.urlImage
        }
}

