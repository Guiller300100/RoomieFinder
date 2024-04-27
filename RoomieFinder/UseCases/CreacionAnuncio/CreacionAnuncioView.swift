//
//  CreacionAnuncioView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct CreacionAnuncioView: View {
    @StateObject var viewModel: CreacionAnuncioViewModel
    @FocusState private var focusedField: AnuncioFieldType?

    init(_ viewModel: CreacionAnuncioViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()
            ScrollView {

                HStack{
                    VistaAnteriorButton()
                    Spacer()
                }
                .padding(.init(top: 13, leading: 15, bottom: 0, trailing: 15))
                .frame(maxWidth: .infinity)

                Text("Creación de anuncio")
                    .customFont(font: .mediumFont, size: 24)
                    .foregroundStyle(Constants.mainColor)
                    .padding(.init(top: 13, leading: 15, bottom: 15, trailing: 15))

                formLabel


                //MARK: BOTON CREAR ANUNCIO
                Button(action: {
//                    viewModel.comprobarFields()
                    viewModel.navigationCheck = true
                }) {
                    Text("Crear anuncio")
                        .customFont(font: .boldFont, size: 15)
                        .frame(width: 127, height: 36)
                        .foregroundStyle(.white)
                        .background(Constants.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 999))
                }

            }
        }

        .alert(isPresented: $viewModel.alertPushCreacionAnuncio, content: {
            Alert(title: Text(viewModel.alertTitleCreacionAnuncio), message: Text(viewModel.alertMessageCreacionAnuncio), dismissButton: .default(Text("Vale")))
        })

        .navigationDestination(isPresented: $viewModel.navigationCheck, destination: {
            withAnimation {
                HomeView(HomeViewModel())
                    .navigationBarBackButtonHidden(true)
            }
        })
    }

    private var formLabel: some View {
        VStack(alignment: .leading) {

            //MARK: ¿Dispones de un piso?
            Text("¿Dispones de un piso?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.pisoSiCheck = true
                viewModel.pisoNoCheck = !viewModel.pisoSiCheck

            } label: {
                HStack {
                    Image(systemName: viewModel.pisoSiCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.pisoNoCheck = true
                viewModel.pisoSiCheck = !viewModel.pisoNoCheck
                viewModel.numHabitaciones = ""

            } label: {
                HStack {
                    Image(systemName: viewModel.pisoNoCheck ? "checkmark.circle.fill" : "circle")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: ¿En que barrio buscas piso/Donde esta el piso?
            Text(viewModel.pisoNoCheck ? "¿En que barrio buscas piso?" : "¿Dónde esta el piso?")
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.direccion, onCommit: {
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
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.tiempoAlquiler, onCommit: {
                focusedField = .presupuesto
            })
            .textFieldStyle(.plain)
            .focused($focusedField, equals: .tiempo)

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            //MARK: ¿Cuál es tu presupuesto máximo/Cuánto vale?
            Text(viewModel.pisoNoCheck ? "¿Cuál es tu presupuesto máximo?" : "¿Cuánto vale?")
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.precio, onCommit: {
                if viewModel.pisoSiCheck {
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
            if viewModel.pisoSiCheck {
                Text("Número de habitaciones")
                    .customFont(font: .boldFont, size: 14)

                TextField("", text: $viewModel.numHabitaciones)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .habitaciones)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Button("Intro") {
                                    focusedField = nil
                                }
                                Spacer()
                            }
                        }
                    }

                Divider()
                    .frame(height: 1)
                    .overlay(Color.gray.opacity(0.7))
                    .padding(.bottom, 16)
            }





        }
        .padding(.init(top: 40, leading: 16, bottom: 0, trailing: 16))
    }

}

private struct VistaAnteriorButton: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 30))
            }
        }
    }
}

#Preview {
    CreacionAnuncioView(CreacionAnuncioViewModel())
}
