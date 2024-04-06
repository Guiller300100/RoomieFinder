//
//  CreacionAnuncioView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 6/4/24.
//

import SwiftUI

struct CreacionAnuncioView: View {

    @StateObject private var creacionAnuncioViewModel = CreacionAnuncioViewModel()
    @FocusState private var focusedField: AnuncioFieldType?

    var body: some View {
        VStack {
            TopBarView()
            ScrollView {
                Text("Creación de anuncio")
                    .customFont(.mediumFont, size: 24)
                    .foregroundStyle(Constants.mainColor)
                    .padding(.init(top: 55, leading: 15, bottom: 15, trailing: 15))


                VStack(alignment: .leading) {

                    //MARK: ¿Dispones de un piso?
                    Text("¿Dispones de un piso?")
                        .customFont(.boldFont, size: 14)
                        .padding(.bottom, 5)

                    Button {
                        creacionAnuncioViewModel.pisoSiCheck = true
                        creacionAnuncioViewModel.pisoNoCheck = !creacionAnuncioViewModel.pisoSiCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionAnuncioViewModel.pisoSiCheck ? "checkmark.circle.fill" : "circle")

                            Text("Si")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }

                    Button {
                        creacionAnuncioViewModel.pisoNoCheck = true
                        creacionAnuncioViewModel.pisoSiCheck = !creacionAnuncioViewModel.pisoNoCheck

                    } label: {
                        HStack {
                            Image(systemName: creacionAnuncioViewModel.pisoNoCheck ? "checkmark.circle.fill" : "circle")

                            Text("No")
                                .customFont(.regularFont, size: 14)
                                .foregroundStyle(.black)
                        }

                    }
                    .padding(.bottom, 16)

                    //MARK: ¿En que barrio buscas piso/Donde esta el piso?
                    Text(creacionAnuncioViewModel.pisoNoCheck ? "¿En que barrio buscas piso?" : "¿Dónde esta el piso?")
                        .customFont(.boldFont, size: 14)

                    TextField("", text: $creacionAnuncioViewModel.direccion, onCommit: {
                        focusedField = .tiempo
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .direccion)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    //MARK: ¿Durante cuanto tiempo?
                    Text("¿Durante cuanto tiempo?")
                        .customFont(.boldFont, size: 14)

                    TextField("", text: $creacionAnuncioViewModel.tiempoAlquiler, onCommit: {
                        focusedField = .presupuesto
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .tiempo)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    //MARK: ¿Cuál es tu presupuesto máximo/Cuánto vale?
                    Text(creacionAnuncioViewModel.pisoNoCheck ? "¿Cuál es tu presupuesto máximo?" : "¿Cuánto vale?")
                        .customFont(.boldFont, size: 14)

                    TextField("", text: $creacionAnuncioViewModel.direccion, onCommit: {
                        if creacionAnuncioViewModel.pisoSiCheck {
                            focusedField = .habitaciones
                        } else {
                            focusedField = nil
                        }
                    })
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .presupuesto)

                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray.opacity(0.7))
                        .padding(.bottom, 16)

                    //MARK: Numero de habitaciones
                    if creacionAnuncioViewModel.pisoSiCheck {
                        Text("Número de habitaciones")
                            .customFont(.boldFont, size: 14)

                        TextField("", text: $creacionAnuncioViewModel.numHabitaciones, onCommit: {
                            focusedField = nil
                        })
                        .textFieldStyle(.plain)
                        .focused($focusedField, equals: .habitaciones)

                        Divider()
                            .frame(height: 1)
                            .overlay(Color.gray.opacity(0.7))
                            .padding(.bottom, 16)
                    }





                }
                .padding(.init(top: 40, leading: 16, bottom: 0, trailing: 16))


                Button(action: {
                    //TODO
                }) {
                    Text("Crear anuncio")
                        .customFont(.boldFont, size: 15)
                        .frame(width: 127, height: 36)
                        .foregroundStyle(.white)
                        .background(Constants.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 999))
                }

            }
        }
    }
}

#Preview {
    CreacionAnuncioView()
}
