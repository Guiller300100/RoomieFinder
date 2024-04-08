//
//  RegistroView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 4/4/24.
//

import SwiftUI

struct RegistroView: View {

    @StateObject private var registroViewModel = RegistroViewModel()
    @FocusState private var focusedField: SignUpType?

    var body: some View {
        VStack {
            TopBarView()
            ScrollView {
                Text("Registro")
                    .customFont(.mediumFont, size: 24)
                    .foregroundStyle(Constants.mainColor)
                    .padding(.init(top: 55, leading: 15, bottom: 15, trailing: 15))


                VStack(alignment: .leading) {

                    Text("Nombre:")
                        .customFont(.boldFont, size: 14)

                    TextField("Nombre", text: $registroViewModel.nombre, onCommit: {
                        focusedField = .apellido
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .nombre)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    Text("Apellido:")
                        .customFont(.boldFont, size: 14)

                    TextField("Apellido", text: $registroViewModel.apellido, onCommit: {
                        focusedField = .correo
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .apellido)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    DatePicker(selection: $registroViewModel.fechaNacimiento, displayedComponents: .date) {
                        Text("Fecha de nacimiento")
                            .customFont(.boldFont, size: 14)
                    }

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.init(top: 10, leading: 0, bottom: 16, trailing: 0))

                    Text("Correo electrónico:")
                        .customFont(.boldFont, size: 14)

                    TextField("Correo electrónico", text: $registroViewModel.correoElectronico, onCommit: {
                        focusedField = .passwordFirst
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .correo)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    Text("Contraseña:")
                        .customFont(.boldFont, size: 14)

                    SecureField("Contraseña", text: $registroViewModel.passwordInput, onCommit: {
                        focusedField = nil
                    })
                    .focused($focusedField, equals: .passwordFirst)


                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    Text("¿Que tipo de usuario eres?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 16)


                    Button {
                        registroViewModel.estudianteCheck = true
                        registroViewModel.PropietarioCheck = !registroViewModel.estudianteCheck

                    } label: {
                        HStack {
                            Image(systemName: registroViewModel.estudianteCheck ? "checkmark.circle.fill" : "circle")

                            Text("Estudiante")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        registroViewModel.PropietarioCheck = true
                        registroViewModel.estudianteCheck = !registroViewModel.PropietarioCheck

                    } label: {
                        HStack {
                            Image(systemName: registroViewModel.PropietarioCheck ? "checkmark.circle.fill" : "circle")

                            Text("Propietario")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                }

                Button(action: {
                    //registroViewModel.comprobarFields()
                    registroViewModel.isRegistred = true
                }) {
                    Text("Registrarse")
                        .customFont(.boldFont, size: 15)
                        .frame(width: 130, height: 36)
                        .foregroundStyle(.white)
                        .background(Constants.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 999))
                }

            }


            .alert(isPresented: $registroViewModel.alertPushRegistro, content: {
                Alert(title: Text(registroViewModel.alertTitleRegistro), message: Text(registroViewModel.alertMessageRegistro), dismissButton: .default(Text("Vale")))
            })

            .navigationDestination(isPresented: $registroViewModel.isRegistred, destination: {
                CreacionPerfilView()
                    .navigationBarBackButtonHidden(true)
            })
            .padding(.horizontal)

        }
    }
}


#Preview {
    RegistroView()
}
