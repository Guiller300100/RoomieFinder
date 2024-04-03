//
//  LoginView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 23/3/24.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseAuth


struct LoginView: View {

    @StateObject private var loginViewModel = LoginViewModel()
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        VStack {
            Text(Constants.titulo)
                .font(.custom(Constants.regularFont, size: 40))

            TextField("Correo", text: $loginViewModel.emailInput, onCommit: {
                focusedField = .email
            })
            .focused($focusedField, equals: .email)
            .padding(.all, 18)
            .frame(width: 330, height: 42)
            .background(Constants.textFieldColor)
            .foregroundStyle(loginViewModel.emailForegroundStyle)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .onChange(of: loginViewModel.emailInput) { newValue in
                loginViewModel.emailDidSubmit()
            }

            SecureField("Contraseña", text: $loginViewModel.passwordInput, onCommit: {
                focusedField = nil
            })
            .focused($focusedField, equals: .email)
            .padding(.all, 18)
            .frame(width: 330, height: 42)
            .background(Constants.textFieldColor)
            .clipShape(RoundedRectangle(cornerRadius: 6))

            Button(action: {
                loginViewModel.navigationIsActive = true
            }, label: {
                Text("Inicio sesión")
                    .font(.custom(Constants.mediumFont, size: 15))
                    .foregroundStyle(!(loginViewModel.emailInput.isEmpty || loginViewModel.passwordInput.isEmpty) && loginViewModel.emailForegroundStyle == .blue ?  .white : Constants.inicioSesionColor)
            })
            .frame(width: 330, height: 35)
            .background(!(loginViewModel.emailInput.isEmpty || loginViewModel.passwordInput.isEmpty) && loginViewModel.emailForegroundStyle == .blue ? Constants.mainColor : Constants.mainColor.opacity(0.36))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.top, 30)
            .disabled((loginViewModel.emailInput.isEmpty || loginViewModel.passwordInput.isEmpty) || loginViewModel.emailForegroundStyle == .red)

            .navigationDestination(isPresented: $loginViewModel.navigationIsActive) {
                MainView()
                    .navigationBarBackButtonHidden()
            }

            Divider()
                .overlay(Rectangle().foregroundStyle(Constants.inicioSesionColor))
                .frame(maxWidth: 330)

            Button(action: {
                if loginViewModel.emailInput.isEmpty || loginViewModel.passwordInput.isEmpty {
                    loginViewModel.alertTitle = "Campos vacíos"
                    loginViewModel.alertMessage = "Por favor, completa todos los campos."
                    loginViewModel.alertPush = true
                } else if loginViewModel.emailForegroundStyle == .red {
                    loginViewModel.alertTitle = "Error en el email"
                    loginViewModel.alertMessage = "Por favor, introduce un email válido."
                    loginViewModel.alertPush = true
                } else if loginViewModel.passwordInput.count < 6 {
                    loginViewModel.alertTitle = "Error en la contraseña"
                    loginViewModel.alertMessage = "Por favor, introduce una contraseña de al menos 6 carácteres."
                    loginViewModel.alertPush = true
                }
                else {
                    loginViewModel.createUser()
                }
            }, label: {
                Text("Registro")
                    .font(.custom(Constants.mediumFont, size: 15))
                    .foregroundStyle(.black)
                    .frame(width: 320, height: 35)
            })
            .frame(width: 330, height: 35)
            .background(Constants.RegistroColor)
            .clipShape(RoundedRectangle(cornerRadius: 6))


            .alert(isPresented: $loginViewModel.alertPush, content: {
                Alert(title: Text(loginViewModel.alertTitle), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("Vale")))
            })

        }
        .onAppear() {
            Analytics.logEvent("InitScreen", parameters: ["message": "Integracion de firebase completada"])

        }
    }
}


#Preview {
    LoginView()
}
