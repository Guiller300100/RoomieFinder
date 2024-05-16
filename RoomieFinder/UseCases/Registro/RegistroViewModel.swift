//
//  RegistroViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import SwiftUI
import Firebase

public class RegistroViewModel: ObservableObject {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared

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
        alertPushRegistro = false
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
            createUser()
        }
    }

    func createUser() {

        Auth.auth().createUser(withEmail: correoElectronico, password: passwordInput) { result, error in
            if let resultDes = result, error == nil {
                print(resultDes)
                self.addData { error in
                    if error != nil {
                        // Handle error from addData
                    } else {
                        self.globalViewModel.getDataCurrentUser()
                        self.isRegistred = true
                    }
            }
            } else {
                self.alertTitleRegistro = "Error"
                self.alertMessageRegistro = "Correo o contraseña incorrectos"
                self.alertPushRegistro = true
                print(error!)
            }
        }
    }

    func addData(completion: @escaping (Error?) -> Void) {

        guard let currentUser = Auth.auth().currentUser else { return }

        DispatchQueue.main.async {
            FirestoreUtils.addData(
                collection: .Perfiles,
                documentData: [
                    "userID": currentUser.uid,
                    "nombre": self.nombre,
                    "apellido": self.apellido,
                    "fnac": self.formatearFecha(date: self.fechaNacimiento)
                ]
            ) { error in
                if let error = error {
                    print("Error adding data:", error)
                    completion(error) // Pass the error to the completion handler
                } else {
                    print("Data added successfully")
                    completion(nil) // Pass nil if successful
                }
            }
        }
        print(currentUser.uid)
    }

    func calcularEdadComoString() -> String {
        let calendar = Calendar.current
        let fechaActual = Date()

        let edadComponents = calendar.dateComponents([.year], from: fechaNacimiento, to: fechaActual)

        if let edad = edadComponents.year {
            return "\(edad)"
        } else {
            return "Edad no disponible"
        }
    }

    func formatearFecha(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    func camposVacios() -> Bool {
        if nombre.isEmpty || apellido.isEmpty || correoElectronico.isEmpty || passwordInput.isEmpty {
            return true
        } else {
            return false
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
