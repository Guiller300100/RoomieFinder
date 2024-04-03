//
//  LoginViewModel.swift
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
        @Published var navigationIsActive = false

        //REGISTRO
        @Published var alertPush = false
        @Published var alertTitle: String = ""
        @Published var alertMessage: String = ""

        func emailDidSubmit() {
            emailForegroundStyle = emailInput.isEmailValid() ? .blue : .red
        }


        func createUser() {

            Auth.auth().createUser(withEmail: emailInput, password: passwordInput) { result, error in
                if let resultDes = result, error == nil {
                    print(resultDes)
                    self.alertTitle = "Usuario registrado"
                    self.alertMessage = "El usuario ha sido registrado correctamente"
                    self.alertPush = true
                } else {
                    self.alertPush = true
                    print(error!)
                }
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
