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
                .customFont(.regularFont, size: 40)


            TextField("Correo", text: $loginViewModel.emailInput, onCommit: {
                focusedField = .pass
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
            .focused($focusedField, equals: .pass)
            .padding(.all, 18)
            .frame(width: 330, height: 42)
            .background(Constants.textFieldColor)
            .clipShape(RoundedRectangle(cornerRadius: 6))

            Button(action: {
                loginViewModel.comprobarFields()
            }, label: {
                Text("Inicio sesión")
                    .customFont(.mediumFont, size: 15)
                    .foregroundStyle(!(loginViewModel.emailInput.isEmpty || loginViewModel.passwordInput.isEmpty) && loginViewModel.emailForegroundStyle == .blue ?  .white : Constants.inicioSesionColor)
                    .frame(width: 320, height: 35)
            })
            .frame(width: 330, height: 35)
            .background(!(loginViewModel.emailInput.isEmpty || loginViewModel.passwordInput.isEmpty) && loginViewModel.emailForegroundStyle == .blue ? Constants.mainColor : Constants.mainColor.opacity(0.36))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.top, 30)
            .disabled((loginViewModel.emailInput.isEmpty || loginViewModel.passwordInput.isEmpty) || loginViewModel.emailForegroundStyle == .red)

            .navigationDestination(isPresented: $loginViewModel.correctLogin) {
                MainView()
                    .navigationBarBackButtonHidden()
            }

            Divider()
                .overlay(Rectangle().foregroundStyle(Constants.inicioSesionColor))
                .frame(maxWidth: 330)

            Button(action: {
                loginViewModel.registreNavigation = true
            }, label: {
                Text("Registro")
                    .customFont(.mediumFont, size: 15)
                    .foregroundStyle(.black)
                    .frame(width: 320, height: 35)
            })
            .frame(width: 330, height: 35)
            .background(Constants.RegistroColor)
            .clipShape(RoundedRectangle(cornerRadius: 6))


            .alert(isPresented: $loginViewModel.alertPush, content: {
                Alert(title: Text(loginViewModel.alertTitle), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("Vale")))
            })

            .navigationDestination(isPresented: $loginViewModel.registreNavigation) {
                RegistroView()
                    .navigationBarBackButtonHidden()
            }

        }
        .onAppear() {
            Analytics.logEvent("InitScreen", parameters: ["message": "Integracion de firebase completada"])

        }
    }
}


#Preview {
    LoginView()
}
