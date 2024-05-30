//
//  RegistroView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct RegistroView: View {
    @StateObject var viewModel: RegistroViewModel
    @FocusState private var focusedField: SignUpType?

    init(_ viewModel: RegistroViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()
            ScrollView {

                titleView

                registroTextsFields

                buttonLabel

            }
            .alert(isPresented: $viewModel.alertPushRegistro, content: {
                Alert(title: Text(viewModel.alertTitleRegistro), message: Text(viewModel.alertMessageRegistro), dismissButton: .default(Text("Vale")))
            })

            .navigationDestination(isPresented: $viewModel.isRegistred, destination: {
                withAnimation(.easeIn) {
                    CreacionPerfilView(CreacionPerfilViewModel(firstTime: true))
                        .navigationBarBackButtonHidden(true)
                }
            })
            .padding(.horizontal)
        }
    }

    private var titleView: some View {
        Text("Registro")
            .customFont(font: .mediumFont, size: 24)
            .foregroundStyle(Constants.mainColor)
            .padding(.init(top: 55, leading: 15, bottom: 15, trailing: 15))
    }


    private var registroTextsFields: some View {
        VStack(alignment: .leading) {

            Text("Nombre:")
                .customFont(font: .boldFont, size: 14)

            TextField("Nombre", text: $viewModel.nombre, onCommit: {
                focusedField = .apellido
            })
            .textFieldStyle(.plain)
            .focused($focusedField, equals: .nombre)

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            Text("Apellido:")
                .customFont(font: .boldFont, size: 14)

            TextField("Apellido", text: $viewModel.apellido, onCommit: {
                focusedField = .correo
            })
            .textFieldStyle(.plain)
            .focused($focusedField, equals: .apellido)

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            DatePicker(selection: $viewModel.fechaNacimiento, displayedComponents: .date) {
                Text("Fecha de nacimiento")
                    .customFont(font: .boldFont, size: 14)
            }

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.init(top: 10, leading: 0, bottom: 16, trailing: 0))

            Text("Correo electrónico:")
                .customFont(font: .boldFont, size: 14)

            TextField("Correo electrónico", text: $viewModel.correoElectronico, onCommit: {
                focusedField = .passwordFirst
            })
            .keyboardType(.emailAddress)
            .textFieldStyle(.plain)
            .focused($focusedField, equals: .correo)

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            Text("Contraseña:")
                .customFont(font: .boldFont, size: 14)

            SecureField("Contraseña", text: $viewModel.passwordInput, onCommit: {
                focusedField = nil
            })
            .focused($focusedField, equals: .passwordFirst)


            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

        }
    }

    private var buttonLabel: some View {
        Button(action: {
            viewModel.comprobarFields()

        }) {
            Text("Registrarse")
                .customFont(font: .boldFont, size: 15)
                .frame(width: 130, height: 36)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))
        }
    }

}

#Preview {
    RegistroView(RegistroViewModel())
}
