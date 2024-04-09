//
//  LoginView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @FocusState private var focusedField: FocusedField?

    init(_ viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {

        switch viewModel.state {
        case .error, .unknownError:
            VStack {
                Text("Here your custom Error view")
            }


        case .empty:
            VStack {
                Text("Here your custom Empty View")
            }

        case .okey, .loading:
            NavigationStack {
                VStack {
                    Text(Constants.titulo)
                        .customFont(.regularFont, size: 40)


                    TextField("Correo", text: $viewModel.emailInput, onCommit: {
                        focusedField = .pass
                    })
                    .focused($focusedField, equals: .email)
                    .padding(.all, 18)
                    .frame(width: 330, height: 42)
                    .background(Constants.textFieldColor)
                    .foregroundStyle(viewModel.emailForegroundStyle)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .onChange(of: viewModel.emailInput) { newValue in
                        viewModel.emailDidSubmit()
                    }

                    SecureField("Contraseña", text: $viewModel.passwordInput, onCommit: {
                        focusedField = nil
                    })
                    .focused($focusedField, equals: .pass)
                    .padding(.all, 18)
                    .frame(width: 330, height: 42)
                    .background(Constants.textFieldColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                    Button(action: {
                        viewModel.comprobarFields()
                    }, label: {
                        Text("Inicio sesión")
                            .customFont(.mediumFont, size: 15)
                            .foregroundStyle(!(viewModel.emailInput.isEmpty || viewModel.passwordInput.isEmpty) && viewModel.emailForegroundStyle == .blue ?  .white : Constants.inicioSesionColor)
                            .frame(width: 320, height: 35)
                    })
                    .frame(width: 330, height: 35)
                    .background(!(viewModel.emailInput.isEmpty || viewModel.passwordInput.isEmpty) && viewModel.emailForegroundStyle == .blue ? Constants.mainColor : Constants.mainColor.opacity(0.36))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding(.top, 30)
                    .disabled((viewModel.emailInput.isEmpty || viewModel.passwordInput.isEmpty) || viewModel.emailForegroundStyle == .red)

                    .navigationDestination(isPresented: $viewModel.correctLogin) {
                        HomeView(HomeViewModel())
                            .navigationBarBackButtonHidden()
                    }

                    Divider()
                        .overlay(Rectangle().foregroundStyle(Constants.inicioSesionColor))
                        .frame(maxWidth: 330)

                    Button(action: {
                        viewModel.registreNavigation = true
                    }, label: {
                        Text("Registro")
                            .customFont(.mediumFont, size: 15)
                            .foregroundStyle(.black)
                            .frame(width: 320, height: 35)
                    })
                    .frame(width: 330, height: 35)
                    .background(Constants.RegistroColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6))


                    .alert(isPresented: $viewModel.alertPush, content: {
                        Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Vale")))
                    })

                    .navigationDestination(isPresented: $viewModel.registreNavigation) {
                        RegistroView(RegistroViewModel())
                            .navigationBarBackButtonHidden()
                    }

                }
            }
        }
    }
    
}


#Preview {
    LoginView(LoginViewModel())
}
