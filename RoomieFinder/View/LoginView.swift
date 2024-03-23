//
//  LoginView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 23/3/24.
//

import SwiftUI

struct LoginView: View {

    @State var correoInput: String = ""
    @State var passwordInput: String = ""
    @State private var isButtonEnabled: Bool = false

    var body: some View {
        VStack {
            Text(Constants.titulo)
                .font(.custom(Constants.regularFont, size: 40))

            TextField("Correo", text: $correoInput)
                .padding(.all, 18)
                .frame(width: 330, height: 42)
                .background(Constants.textFieldColor)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            SecureField("Contraseña", text: $passwordInput)
                .padding(.all, 18)
                .frame(width: 330, height: 42)
                .background(Constants.textFieldColor)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            if (correoInput.isEmpty || passwordInput.isEmpty) {
                Button(action: {
                }, label: {
                    Text("Inicio sesión")
                        .font(.custom(Constants.mediumFont, size: 15))
                        .foregroundStyle(Constants.inicioSesionColor)
                        .frame(width: 320, height: 35)
                })
                .frame(width: 330, height: 35)
                .background(Constants.mainColor.opacity(0.36))
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.top, 30)
                .disabled(true)

            } else {
                Button(action: {
                }, label: {
                    Text("Inicio sesión")
                        .font(.custom(Constants.mediumFont, size: 15))
                        .foregroundStyle(.white)
                })
                .frame(width: 330, height: 35)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.top, 30)
            }

            
            Divider()
                .overlay(Rectangle().foregroundStyle(Constants.inicioSesionColor))
                .frame(maxWidth: 330)

                Button(action: {
                    print("Pulsado")
                }, label: {
                    Text("Registro")
                        .font(.custom(Constants.mediumFont, size: 15))
                        .foregroundStyle(.black)
                        .frame(width: 320, height: 35)
                })
                .frame(width: 330, height: 35)
                .background(Constants.RegistroColor)
                .clipShape(RoundedRectangle(cornerRadius: 6))


        }
    }
}


#Preview {
    LoginView()
}
