//
//  CreacionAnuncioView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 6/4/24.
//

import Foundation
import Firebase

extension CreacionAnuncioView {

    @MainActor class CreacionAnuncioViewModel: ObservableObject {

        //VARIABLES
        @Published var direccion = ""
        @Published var tiempoAlquiler = ""
        @Published var numHabitaciones = ""

        //RADIOBUTTONS
        @Published var pisoSiCheck = false
        @Published var pisoNoCheck = true

    }
}


enum AnuncioFieldType {
    case direccion
    case tiempo
    case presupuesto
    case habitaciones
}
