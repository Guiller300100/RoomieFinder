//
//  swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 3/4/24.
//

import Foundation
import FirebaseAuth
import SwiftUI

extension LoginView {

    @MainActor class LoginViewModel: ObservableObject {
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

        func emailDidSubmit() {
            emailForegroundStyle = emailInput.isEmailValid() ? .blue : .red
        }

        
        func comprobarFields() {
            if emailInput.isEmpty || passwordInput.isEmpty {
                alertTitle = "Campos vacíos"
                alertMessage = "Por favor, completa todos los campos."
                alertPush = true
            } else if emailForegroundStyle == .red {
                alertTitle = "Error en el email"
                alertMessage = "Por favor, introduce un email válido."
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
            Auth.auth().signIn(withEmail: emailInput, password: passwordInput) { [weak self] authResult, error in
                guard let strongSelf = self else { return }

                if let error = error {
                    // Manejar el error
                    print("Error al iniciar sesión: \(error.localizedDescription)")

                    // Establecer incorrectoLogin en true
                    self!.alertTitle = "Error"
                    self!.alertMessage = "Correo o contraseña incorrectos"
                    self!.alertPush = true
                    return
                }

                // El inicio de sesión fue exitoso
                // Establecer correctoLogin en true
                self?.correctLogin = true
            }
        }

    }
}

enum FocusedField {
    case pass, email
}


extension String {
    public func isEmailValid() -> Bool {
        guard !isEmpty else {
            return false
        }
        // TODO: type.regex en utils
        let regTest = NSPredicate(format: "SELF MATCHES %@", "[\\w.\\-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return regTest.evaluate(with: self)
    }
}
