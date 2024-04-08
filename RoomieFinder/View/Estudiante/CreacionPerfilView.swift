//
//  CreacionPerfilView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 6/4/24.
//

import SwiftUI

struct CreacionPerfilView: View {

    @StateObject private var creacionViewModel = CreacionPerfilViewModel()
    @FocusState private var focusedField: CreacionType?


    var body: some View {
        VStack {
            TopBarView()
            ScrollView {

                VStack {
                    Text("Creación de perfil")
                        .customFont(.mediumFont, size: 24)
                        .foregroundStyle(Constants.mainColor)
                        .padding(.init(top: 55, leading: 15, bottom: 15, trailing: 15))


                    Image(uiImage: creacionViewModel.avatarImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .overlay(
                            Circle()
                                .stroke(Constants.mainColor, lineWidth: 3)
                        )
                        .onTapGesture {
                            creacionViewModel.isShowingPhotoPicker = true
                        }

                        .padding(.bottom, 10)
                }

                VStack(alignment: .leading) {
                    //MARK: ¿Qué estudias o que vas a estudiar?
                    Text("¿Qué estudias o que vas a estudiar?")
                        .customFont(.boldFont, size: 14)

                    TextField("", text: $creacionViewModel.estudios, onCommit: {
                        focusedField = .universidad
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .estudios)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    //MARK: ¿En qué universidad?
                    Text("¿En qué universidad?")
                        .customFont(.boldFont, size: 14)

                    TextField("", text: $creacionViewModel.universidad, onCommit: {
                        focusedField = .tiempoLibre
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .universidad)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    //MARK: ¿Que idiomas hablas?
                    Text("¿Que idiomas hablas?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 5)

                    Button {
                        creacionViewModel.isMultiPickerOpen.toggle()
                    } label: {
                        HStack
                        {
                            if creacionViewModel.idiomas.isEmpty {
                                Text("Selecciona idiomas")
                                    .foregroundColor(Color.gray)
                            } else {
                                Text(creacionViewModel.idiomas.map({ $0.rawValue }).joined(separator: ", "))
                            }

                            Spacer()

                            Image(systemName: creacionViewModel.isMultiPickerOpen ? "chevron.down" : "chevron.right")
                                .foregroundColor(.black)
                                .rotationEffect(.degrees(creacionViewModel.isMultiPickerOpen ? 180 : 0))
                                .onTapGesture {
                                    creacionViewModel.isMultiPickerOpen.toggle()
                                }
                        }
                    }
                    .foregroundColor(.black)

                    if creacionViewModel.isMultiPickerOpen {
                        MultiPicker(selectedItems: $creacionViewModel.idiomas, options: Idiomas.allCases)
                            .padding(.top, 4)
                    }

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    //MARK: Sexo
                    Text("Sexo:")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 5)

                    Button {
                        creacionViewModel.hombreCheck = true
                        creacionViewModel.mujerCheck = !creacionViewModel.hombreCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.hombreCheck ? "checkmark.circle.fill" : "circle")

                            Text("Hombre")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        creacionViewModel.mujerCheck = true
                        creacionViewModel.hombreCheck = !creacionViewModel.mujerCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.mujerCheck ? "checkmark.circle.fill" : "circle")

                            Text("Mujer")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }
                    .padding(.bottom, 16)

                    //MARK: ¿Como consideras que eres?
                    Text("¿Como consideras que eres?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 5)

                    Button {
                        creacionViewModel.activoCheck = true
                        creacionViewModel.tranquiloCheck = !creacionViewModel.activoCheck
                        creacionViewModel.ambosCheck = !creacionViewModel.activoCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.activoCheck ? "checkmark.circle.fill" : "circle")

                            Text("Activo")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        creacionViewModel.tranquiloCheck = true
                        creacionViewModel.activoCheck = !creacionViewModel.tranquiloCheck
                        creacionViewModel.ambosCheck = !creacionViewModel.tranquiloCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.tranquiloCheck ? "checkmark.circle.fill" : "circle")

                            Text("Tranquilo")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        creacionViewModel.ambosCheck = true
                        creacionViewModel.tranquiloCheck = !creacionViewModel.ambosCheck
                        creacionViewModel.activoCheck = !creacionViewModel.ambosCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.ambosCheck ? "checkmark.circle.fill" : "circle")

                            Text("50/50")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }
                    .padding(.bottom, 16)

                    //MARK: ¿Prefieres un ambiente tranquilo o más social en casa?
                    Text("¿Prefieres un ambiente tranquilo o más social en casa?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 5)

                    Button {
                        creacionViewModel.ambienteSocialCheck = true
                        creacionViewModel.ambienteTranquiloCheck = !creacionViewModel.ambienteSocialCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.ambienteSocialCheck ? "checkmark.circle.fill" : "circle")

                            Text("Social")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        creacionViewModel.ambienteTranquiloCheck = true
                        creacionViewModel.ambienteSocialCheck = !creacionViewModel.ambienteTranquiloCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.ambienteTranquiloCheck ? "checkmark.circle.fill" : "circle")

                            Text("Tranquilo")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }
                    .padding(.bottom, 16)

                    //MARK: ¿Qué te gusta hacer en tu tiempo libre?
                    Text("¿Qué te gusta hacer en tu tiempo libre?")
                        .customFont(.boldFont, size: 14)

                    TextField("", text: $creacionViewModel.tiempoLibre, onCommit: {
                        focusedField = .descripcion
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .tiempoLibre)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    //MARK: ¿Sueles fumar en tu dia a dia?
                    Text("¿Sueles fumar en tu dia a dia?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 5)

                    Button {
                        creacionViewModel.fumarSiCheck = true
                        creacionViewModel.fumarNoCheck = !creacionViewModel.fumarSiCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.fumarSiCheck ? "checkmark.circle.fill" : "circle")

                            Text("Si")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        creacionViewModel.fumarNoCheck = true
                        creacionViewModel.fumarSiCheck = !creacionViewModel.fumarNoCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.fumarNoCheck ? "checkmark.circle.fill" : "circle")

                            Text("No")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }
                    .padding(.bottom, 16)

                    //MARK: ¿Te gusta salir mucho de fiesta?
                    Text("¿Te gusta salir mucho de fiesta?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 5)

                    Button {
                        creacionViewModel.fiestaSiCheck = true
                        creacionViewModel.fiestaNoCheck = !creacionViewModel.fiestaSiCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.fiestaSiCheck ? "checkmark.circle.fill" : "circle")

                            Text("Si")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        creacionViewModel.fiestaNoCheck = true
                        creacionViewModel.fiestaSiCheck = !creacionViewModel.fiestaNoCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionViewModel.fiestaNoCheck ? "checkmark.circle.fill" : "circle")

                            Text("No")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }
                    .padding(.bottom, 16)

                    //MARK: Descríbete para conocerte más:
                    Text("Descríbete para conocerte más:")
                        .customFont(.boldFont, size: 14)

                    TextField("", text: $creacionViewModel.descripcion, onCommit: {
                        focusedField = nil
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .descripcion)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                }
                .padding(.init(top: 40, leading: 16, bottom: 0, trailing: 16))

                //MARK: BOTON GUARDAR
                Button(action: {
                    //creacionViewModel.comprobarField()
                    creacionViewModel.navigationCheck = true
                }) {
                    Text("Guardar")
                        .customFont(.boldFont, size: 15)
                        .frame(width: 92, height: 36)
                        .foregroundStyle(.white)
                        .background(Constants.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 999))
                }


            }

        }

        .alert(isPresented: $creacionViewModel.alertPushCreacionPerfil, content: {
            Alert(title: Text(creacionViewModel.alertTitleCreacionPerfil), message: Text(creacionViewModel.alertMessageCreacionPerfil), dismissButton: .default(Text("Vale")))
        })

        .sheet(isPresented: $creacionViewModel.isShowingPhotoPicker, content: {
            PhotoPicker.init(avatarImage: $creacionViewModel.avatarImage)
        })

        .navigationDestination(isPresented: $creacionViewModel.navigationCheck, destination: {
            CreacionAnuncioView()
                .navigationBarBackButtonHidden(true)
        })
    }
}

#Preview {
    CreacionPerfilView()
}
