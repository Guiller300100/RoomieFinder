//
//  LoginView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @FocusState private var focusedField: FocusedField?

    //Datos globables
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    init(_ viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        NavigationStack {
            VStack {
                title

                emailTextField

                passTextField


                logInButton

                Divider()
                    .overlay(Rectangle().foregroundStyle(Constants.inicioSesionColor))
                    .frame(maxWidth: 330)


                registreButton
            }

            .alert(isPresented: $viewModel.alertPush, content: {
                Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Vale")))
            })

            .navigationDestination(isPresented: $viewModel.correctLogin) {
                withAnimation {
                    HomeView(HomeViewModel())
                        .navigationBarBackButtonHidden()
                }
            }

            .navigationDestination(isPresented: $viewModel.registreNavigation) {
                withAnimation {
                    RegistroView(RegistroViewModel())
                        .navigationBarBackButtonHidden()
                }
            }
        }

    }


    private var title: some View {
        Text(Constants.titulo)
            .customFont(font: .regularFont, size: 40)
    }

    private var emailTextField: some View {

        TextField("Correo", text: $viewModel.emailInput, onCommit: {
            focusedField = .pass

        })

        .focused($focusedField, equals: .email)
        .padding(.all, 18)
        .frame(width: 330, height: 42)
        .background(Constants.textFieldColor)
        .foregroundStyle(viewModel.emailForegroundStyle)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private var passTextField: some View {

        SecureField("Contraseña", text: $viewModel.passwordInput, onCommit: {
            focusedField = nil
        })
        .focused($focusedField, equals: .pass)
        .padding(.all, 18)
        .frame(width: 330, height: 42)
        .background(Constants.textFieldColor)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private var logInButton: some View {
        Button(action: {
            globalViewModel.fromLogin = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                viewModel.comprobarFields()
            }
        }, label: {
            Text("Inicio sesión")
                .customFont(font: .mediumFont, size: 15)
                .foregroundStyle(!(viewModel.emailInput.isEmpty || viewModel.passwordInput.isEmpty) ?  .white : Constants.inicioSesionColor)
                .frame(width: 320, height: 35)
        })
        .frame(width: 330, height: 35)
        .background(!(viewModel.emailInput.isEmpty || viewModel.passwordInput.isEmpty) ? Constants.mainColor : Constants.mainColor.opacity(0.36))
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .padding(.top, 30)
        .disabled((viewModel.emailInput.isEmpty || viewModel.passwordInput.isEmpty))
    }

    private var registreButton: some View {
        Button(action: {
            viewModel.registreNavigation = true
        }, label: {
            Text("Registro")
                .customFont(font: .mediumFont, size: 15)
                .foregroundStyle(.black)
                .frame(width: 320, height: 35)
        })
        .frame(width: 330, height: 35)
        .background(Constants.RegistroColor)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}


#Preview {
    LoginView(LoginViewModel())
}
