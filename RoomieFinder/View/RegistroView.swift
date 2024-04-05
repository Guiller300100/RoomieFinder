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
                    .customFont(.mediumFont, size: 14)
                    .foregroundStyle(Constants.mainColor)
                    .padding(.all, 15)

                Spacer()

                VStack(alignment: .leading) {

                    Text("Nombre:")
                        .customFont(.boldFont, size: 14)

                    TextField("Nombre", text: $registroViewModel.nombre, onCommit: {
                        focusedField = .apellido
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .nombre)

                    Divider()
                        .padding(.bottom, 16)

                    Text("Apellido:")
                        .customFont(.boldFont, size: 14)

                    TextField("Apellido", text: $registroViewModel.apellido, onCommit: {
                        focusedField = .correo
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .apellido)

                    Divider()
                        .padding(.bottom, 16)

                    DatePicker(selection: $registroViewModel.fechaNacimiento, displayedComponents: .date) {
                        Text("Fecha de nacimiento")
                            .customFont(.boldFont, size: 14)
                    }

                    Divider()
                        .padding(.bottom, 16)

                    Text("Correo electrónico:")
                        .customFont(.boldFont, size: 14)

                    TextField("Correo electrónico", text: $registroViewModel.correoElectronico, onCommit: {
                        focusedField = .passwordFirst
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .correo)

                    Divider()
                        .padding(.bottom, 16)

                    Text("Contraseña:")
                        .customFont(.boldFont, size: 14)

                    SecureField("Contraseña", text: $registroViewModel.passwordInput, onCommit: {
                        focusedField = nil
                    })
                    .focused($focusedField, equals: .passwordFirst)


                    Divider()
                        .padding(.bottom, 16)

                    Text("¿Que tipo de usuario eres?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 16)


                    Button {
                        registroViewModel.estudianteCheck.toggle()
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
                        registroViewModel.PropietarioCheck.toggle()
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
                    registroViewModel.comprobarFields()
                }) {
                    Text("Registrarse")
                        .customFont(.boldFont, size: 15)
                        .frame(width: 130, height: 36)
                        .foregroundStyle(.white)
                        .background(Constants.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 999))
                }

            }

            .alert(isPresented: $registroViewModel.alertPush, content: {
                Alert(title: Text(registroViewModel.alertTitleRegistro), message: Text(registroViewModel.alertMessageRegistro), dismissButton: .default(Text("Vale")))
            })

            .navigationDestination(isPresented: $registroViewModel.isRegistred, destination: {
                MainView()
                    .navigationBarBackButtonHidden(true)
            })
            .padding()



        }
    }
}


#Preview {
    RegistroView()
}
