//
//  RegistroViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import Firebase

public class RegistroViewModel: ObservableObject {

    //TEXTFIELDS
    @Published var nombre: String = ""
    @Published var apellido: String = ""
    @Published var fechaNacimiento: Date = Date()
    @Published var correoElectronico: String = ""
    @Published var passwordInput: String = ""

    //RADIOBUTTONS
    @Published var estudianteCheck = true
    @Published var PropietarioCheck = false

    //NAVIGATION STATE
    @Published var isRegistred = false

    //ALERTAS
    @Published var alertPushRegistro = false
    @Published var alertTitleRegistro: String = ""
    @Published var alertMessageRegistro: String = ""

    func comprobarFields() {
        if camposVacios() {
            alertTitleRegistro = "Campos vacíos"
            alertMessageRegistro = "Por favor, completa todos los campos."
            alertPushRegistro = true
        } else if passwordInput.count < 6 {
            alertTitleRegistro = "Error en la contraseña"
            alertMessageRegistro = "Por favor, introduce una contraseña de al menos 6 carácteres."
            alertPushRegistro = true
        }
        else {
            addData()
            createUser()
        }
    }

    func addData() {
        
        

    }

    func camposVacios() -> Bool {
        if nombre.isEmpty || apellido.isEmpty || correoElectronico.isEmpty || passwordInput.isEmpty {
            return true
        } else {
            return false
        }


    }

    func createUser() {

        Auth.auth().createUser(withEmail: correoElectronico, password: passwordInput) { result, error in
            if let resultDes = result, error == nil {
                print(resultDes)
                self.isRegistred = true
            } else {
                self.alertTitleRegistro = "Error"
                self.alertMessageRegistro = "Correo o contraseña incorrectos"
                self.alertPushRegistro = true
                print(error!)
            }
        }
    }


    public func onAppear() {

    }

    public func actionFromView() {
        // Example of private method
    }


}

enum SignUpType {
    case nombre
    case apellido
    case correo
    case passwordFirst
}
