//
//  PerfilModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 21/3/24.
//
//   let Perfils = try? JSONDecoder().decode(Perfils.self, from: jsonData)

import Foundation

// MARK: - Perfil
struct Perfil: Codable, Identifiable, Equatable {
    let id = UUID().uuidString
    let nombre: String?
    let edad, presupuesto: Int?
    let barrio: String?
    var favorito: Bool

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case nombre = "Nombre"
        case edad = "Edad"
        case presupuesto = "Presupuesto"
        case barrio = "Barrio"
        case favorito = "Favorito"
    }

    init(nombre: String?, edad: Int?, presupuesto: Int?, barrio: String?, favorito: Bool) {
        self.nombre = nombre
        self.edad = edad
        self.presupuesto = presupuesto
        self.barrio = barrio
        self.favorito = favorito
    }
}

struct Usuario: Identifiable {
    var id: String
    var userID: String
    var nombre: String
    var apellido: String
    var fnac: String
    var info: Info
}


struct Info {
    var prueba: String
//    var estudios: String
//    var universidad: String
//    var idiomas: Set<Idiomas>
//    var sexo: String
//    var tipoPersona: String
//    var ambiente: String
//    var tiempoLibre: String
//    var fumar: Bool
//    var fiesta: Bool
//    var descripcion: String
}
