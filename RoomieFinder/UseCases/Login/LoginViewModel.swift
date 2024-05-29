//
//  LoginViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import FirebaseAuth
import SwiftUI


public class LoginViewModel: ObservableObject {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    //TEXTFIELDS
    @Published var emailInput: String = ""
    @Published var passwordInput: String = ""
    @Published var emailForegroundStyle = Color.black

    //BUTTONS
    @Published var correctLogin = false
    @Published var registreNavigation = false

    //ALERTAS
    @Published var alertPush = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""


    func comprobarFields() {
        if emailInput.isEmpty || passwordInput.isEmpty {
            alertTitle = "Campos vacíos"
            alertMessage = "Por favor, completa todos los campos."
            alertPush = true
        } else if passwordInput.count < 6 {
            alertTitle = "Error en la contraseña"
            alertMessage = "Por favor, introduce una contraseña de al menos 6 carácteres."
            alertPush = true
        }
        else {
            signIn()
        }

    }

    func signIn() {
        Auth.auth().signIn(withEmail: emailInput, password: passwordInput) { authResult, error in

            if let error = error {
                // Manejar el error
                print("Error al iniciar sesión: \(error.localizedDescription)")

                // Establecer incorrectoLogin en true
                self.alertTitle = "Error"
                self.alertMessage = "Correo o contraseña incorrectos"
                self.alertPush = true
                self.passwordInput = ""
                return
            }

            // El inicio de sesión fue exitoso
            // Establecer correctoLogin en true
            self.globalViewModel.getAllAds()
            self.globalViewModel.getDataCurrentUser()
            self.globalViewModel.getAllUsers()
            self.globalViewModel.getFav()
            self.correctLogin = true
        }
    }

}



    enum FocusedField {
        case pass, email
    }

    public func onAppear() {
        
    }
