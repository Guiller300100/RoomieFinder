//
//  CreacionAnuncioViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class CreacionAnuncioViewModel: BaseViewModel, ObservableObject {
    var business = CreacionAnuncioBusiness()
    var state: ViewModelState = .okey
    var showWarningError = false
    @Published var modelView: CreacionAnuncioModelView
    var dto: CreacionAnuncioDTO?

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

    init(dto: CreacionAnuncioDTO? = nil) {
        self.dto = dto

        self.modelView = CreacionAnuncioModelView(modelBusiness: nil)
    }

    func comprobarFields() {

        if direccion.isEmpty || tiempoAlquiler.isEmpty || precio.isEmpty || ( pisoSiCheck && numHabitaciones.isEmpty)  {

            alertTitleCreacionAnuncio = "Campos vacíos"
            alertMessageCreacionAnuncio = "Por favor, completa todos los campos."
            alertPushCreacionAnuncio = true

        } else {

            navigationCheck = true
        }

    }

    public func onAppear() {

    }
    
    public func actionFromView() {
        // Example of private method
    }

    
}

struct CreacionAnuncioDTO {
    // Añadir propiedades del DTO si fuese necesario
}


enum AnuncioFieldType {
    case direccion
    case tiempo
    case presupuesto
    case habitaciones
}
