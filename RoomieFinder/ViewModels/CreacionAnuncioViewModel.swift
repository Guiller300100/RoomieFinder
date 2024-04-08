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
        @Published var precio = ""
        @Published var numHabitaciones = ""

        //RADIOBUTTONS
        @Published var pisoSiCheck = false
        @Published var pisoNoCheck = true

        //NAVIGATION CHECK
        @Published var navigationCheck = false

        //ALERTAS
        @Published var alertPushCreacionAnuncio = false
        @Published var alertTitleCreacionAnuncio: String = ""
        @Published var alertMessageCreacionAnuncio: String = ""


        func comprobarFields() {

            if direccion.isEmpty || tiempoAlquiler.isEmpty || precio.isEmpty || ( pisoSiCheck && numHabitaciones.isEmpty)  {

                alertTitleCreacionAnuncio = "Campos vacíos"
                alertMessageCreacionAnuncio = "Por favor, completa todos los campos."
                alertPushCreacionAnuncio = true

            } else {

                navigationCheck = true
            }

        }



    }

}


enum AnuncioFieldType {
    case direccion
    case tiempo
    case presupuesto
    case habitaciones
}
