//
//  ContentView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI
import Firebase

struct TopBarView: View {

    @State private var navigationLogin = false

    var body: some View {

        VStack {
            HStack {
                Text(Constants.titulo)
                    .customFont(.mediumFont, size: 24)
                Spacer()

                Button(action: {

                    if Auth.auth().currentUser != nil {
                        do {
                            try Auth.auth().signOut()
                            // Cerrar sesión exitosamente
                            print("Sesión cerrada exitosamente.")
                        } catch let error as NSError {
                            // Manejar el error
                            print("Error al cerrar sesión: \(error.localizedDescription)")
                        }
                    }

                    navigationLogin.toggle()

                }, label: {
                    if Auth.auth().currentUser != nil {
                        // El usuario está autenticado
                        Text("Cerrar Sesión")
                            .customFont(.boldFont, size: 14)
                    } else {
                        // El usuario no está autenticado
                        Text("Iniciar Sesión")
                            .customFont(.boldFont, size: 14)
                    }

                })
                .frame(width: 130, height: 36)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))

                .navigationDestination(isPresented: $navigationLogin) {
                    LoginView()
                        .navigationBarBackButtonHidden()
                }

            }
            .padding(.init(top: 5, leading: 19, bottom: 0, trailing: 10))
            Divider()
                .frame(height: 1)
                .overlay(Constants.mainColor.opacity(0.7))
        }
    }
}

#Preview {
    TopBarView()
}
