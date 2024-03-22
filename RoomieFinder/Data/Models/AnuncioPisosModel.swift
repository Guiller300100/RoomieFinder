//
//  PisosModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 22/3/24.
//

import Foundation

class AnuncioPisosModel: Codable, Identifiable {
    let idAnuncio: Int?
    let dirección: String?
    let numHabitaciones, numBaños, precio: Int?
    let descripción: String?

    enum CodingKeys: String, CodingKey {
        case idAnuncio = "ID_Anuncio"
        case dirección = "Dirección"
        case numHabitaciones = "Num_habitaciones"
        case numBaños = "Num_Baños"
        case precio = "Precio"
        case descripción = "Descripción"
    }

    init(idAnuncio: Int?, dirección: String?, numHabitaciones: Int?, numBaños: Int?, precio: Int?, descripción: String?) {
        self.idAnuncio = idAnuncio
        self.dirección = dirección
        self.numHabitaciones = numHabitaciones
        self.numBaños = numBaños
        self.precio = precio
        self.descripción = descripción
    }
}
