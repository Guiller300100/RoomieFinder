//
//  RegistroViewModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 4/4/24.
//

import Foundation
import Firebase

extension RegistroView {

    @MainActor class RegistroViewModel: ObservableObject {
        //TEXTFIELDS
        @Published var nombre: String = ""
        @Published var apellido: String = ""
        @Published var fechaNacimiento: Date = Date()
        @Published var correoElectronico: String = ""
        @Published var passwordInput: String = ""

        //RADIOBUTTONS
        @Published var estudianteCheck = false
        @Published var PropietarioCheck = false

        //NAVIGATION STATE
        @Published var isRegistred = false
        @Published var alertPush = false

        //ALERTAS
        @Published var alertPushRegistro = false
        @Published var alertTitleRegistro: String = ""
        @Published var alertMessageRegistro: String = ""

        func comprobarFields() {
            if emailInput.isEmpty || passwordInput.isEmpty {
                alertTitleRegistro = "Campos vacíos"
                alertMessageRegistro = "Por favor, completa todos los campos."
                alertPushRegistro = true
            } else if emailForegroundStyle == .red {
                alertTitleRegistro = "Error en el email"
                alertMessageRegistro = "Por favor, introduce un email válido."
                alertPushRegistro = true
            } else if passwordInput.count < 6 {
                alertTitleRegistro = "Error en la contraseña"
                alertMessageRegistro = "Por favor, introduce una contraseña de al menos 6 carácteres."
                alertPushRegistro = true
            }
            else {
                createUser()
            }

        }

        func createUser() {

            Auth.auth().createUser(withEmail: correoElectronico, password: passwordInput) { result, error in
                if let resultDes = result, error == nil {
                    print(resultDes)
                    self.isRegistred = true
                } else {
                    self.alertPush = true
                    print(error!)
                }
            }
        }
    }
}

enum SignUpType {
    case nombre
    case apellido
    case correo
    case passwordFirst
}
