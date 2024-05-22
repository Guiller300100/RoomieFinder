//
//  CreacionAnuncioView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct CreacionAnuncioView: View {
    @StateObject var viewModel: CreacionAnuncioViewModel
    @FocusState private var focusedField: AnuncioFieldType?
    @Environment(\.presentationMode) var presentationMode

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

                textLabel

                formLabel

                buttonLabel
            }
        }
        .onAppear() {
            viewModel.onAppear()
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

    private var textLabel: some View {
        Text(viewModel.anuncioSelected != nil ? "Modifica tu anuncio" : "Creación de anuncio")
            .customFont(font: .mediumFont, size: 24)
            .foregroundStyle(Constants.mainColor)
            .padding(.init(top: 13, leading: 15, bottom: 15, trailing: 15))
    }

    private var formLabel: some View {
        VStack(alignment: .leading) {

            //MARK: ¿Dispones de un piso?
            Text("¿Dispones de un piso?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.pisoCheck = true

            } label: {
                HStack {
                    Image(systemName: viewModel.pisoCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.pisoCheck = false
                viewModel.numHabitaciones = ""

            } label: {
                HStack {
                    Image(systemName: !viewModel.pisoCheck ? "checkmark.circle.fill" : "circle")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: ¿En que barrio buscas piso/Donde esta el piso?
            Text(viewModel.pisoCheck ? "¿Dónde esta el piso? (No pongas la dirección exacta, solo el barrio o la zona, por privacidad)" : "¿En que zona/barrio buscas piso?")
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
            Text("¿Durante cuanto tiempo? (Especifica meses o año)")
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
            Text(viewModel.pisoCheck ? "¿Cuánto vale?" : "¿Cuál es tu presupuesto máximo?")
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.precio, onCommit: {
                if viewModel.pisoCheck {
                    focusedField = .habitaciones
                } else {
                    focusedField = nil
                }
            })
            .keyboardType(.numberPad)
            .textFieldStyle(.plain)
            .focused($focusedField, equals: .presupuesto)

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            //MARK: Numero de habitaciones
            if viewModel.pisoCheck {
                Text("Número de habitaciones")
                    .customFont(font: .boldFont, size: 14)

                TextField("", text: $viewModel.numHabitaciones)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.plain)
                    .focused($focusedField, equals: .habitaciones)
                    .toolbar {
                        if focusedField == .habitaciones {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Button("Fin") {
                                        focusedField = nil
                                    }
                                    Spacer()
                                }
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

    private var buttonLabel: some View {
        //MARK: BOTON CREAR ANUNCIO
        Button(action: {

            viewModel.comprobarFields { firstTime in
                if firstTime {
                    viewModel.navigationCheck = true
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }) {
            Text(viewModel.anuncioSelected != nil ? "Modificar anuncio" : "Crear anuncio")
                .customFont(font: .boldFont, size: 15)
                .frame(width: 140, height: 36)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))
        }
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
    CreacionAnuncioView(CreacionAnuncioViewModel(firstTime: true))
}
