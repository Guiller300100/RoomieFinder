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

