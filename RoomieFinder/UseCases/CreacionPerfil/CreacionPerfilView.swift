//
//  CreacionPerfilView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct CreacionPerfilView: View {

    @StateObject var viewModel: CreacionPerfilViewModel
    @FocusState private var focusedField: CreacionType?
    @Environment(\.presentationMode) var presentationMode

    init(_ viewModel: CreacionPerfilViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()
            ScrollView {

                if !viewModel.firstTime {
                    HStack{
                        vistaAnteriorButton
                        Spacer()
                    }
                    .padding(.init(top: 13, leading: 15, bottom: 0, trailing: 15))
                    .frame(maxWidth: .infinity)
                }

                if viewModel.firstTime {
                    titleAndPhoto
                }

                formLabel

                buttonLabel

            }

        }
        .onAppear() {
            viewModel.onAppear()
        }
        .alert(isPresented: $viewModel.alertPushCreacionPerfil, content: {
            Alert(title: Text(viewModel.alertTitleCreacionPerfil), message: Text(viewModel.alertMessageCreacionPerfil), dismissButton: .default(Text("Vale")))
        })

        .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
            PhotoPicker.init(avatarImage: $viewModel.avatarImage) {
                _ = viewModel.uploadPhoto()
            }
        })

        .navigationDestination(isPresented: $viewModel.navigationCheck, destination: {
            withAnimation {
                CreacionAnuncioView(CreacionAnuncioViewModel(firstTime: true))
                    .navigationBarBackButtonHidden(true)
            }
        })
    }

    private var titleAndPhoto: some View {
        VStack {
            Text("Creación de perfil")
                .customFont(font: .mediumFont, size: 24)
                .foregroundStyle(Constants.mainColor)
                .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))


            Image(uiImage: viewModel.avatarImage)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .overlay(
                    Circle()
                        .stroke(Constants.mainColor, lineWidth: 3)
                )
                .onTapGesture {
                    viewModel.isShowingPhotoPicker = true
                }
                .padding(.bottom, 10)
        }
    }


    private var formLabel: some View {
        VStack(alignment: .leading) {
            //MARK: ¿Qué estudias o que vas a estudiar?
            Text("¿Qué estudias o que vas a estudiar?")
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.estudios, onCommit: {
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
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.universidad, onCommit: {
                focusedField = .tiempoLibre
            })
            .textFieldStyle(.plain)
            .focused($focusedField, equals: .universidad)

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            //MARK: Trabajas
            Text("¿Trabajas?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.trabaja = true

            } label: {
                HStack {
                    Image(systemName: viewModel.trabaja ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.trabaja = false
            } label: {
                HStack {
                    Image(systemName: !viewModel.trabaja ? "checkmark.circle.fill" : "circle")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: ¿Que idiomas hablas?
            Text("¿Que idiomas hablas?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.isMultiPickerOpen.toggle()
            } label: {
                HStack
                {
                    if viewModel.idiomas.isEmpty {
                        Text("Selecciona idiomas")
                            .foregroundColor(Color.gray)
                    } else {
                        Text(viewModel.idiomas.map({ $0.rawValue }).joined(separator: ", "))
                    }

                    Spacer()

                    Image(systemName: viewModel.isMultiPickerOpen ? "chevron.down" : "chevron.right")
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(viewModel.isMultiPickerOpen ? 180 : 0))
                        .onTapGesture {
                            viewModel.isMultiPickerOpen.toggle()
                        }
                }
            }
            .foregroundColor(.black)

            if viewModel.isMultiPickerOpen {
                MultiPicker(selectedItems: $viewModel.idiomas, options: Idiomas.allCases)
                    .padding(.top, 4)
            }

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            //MARK: Sexo
            Text("Sexo:")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.hombreCheck = true
                viewModel.mujerCheck = !viewModel.hombreCheck

            } label: {
                HStack {
                    Image(systemName: viewModel.hombreCheck ? "checkmark.circle.fill" : "circle")

                    Text("Hombre")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.mujerCheck = true
                viewModel.hombreCheck = !viewModel.mujerCheck
            } label: {
                HStack {
                    Image(systemName: viewModel.mujerCheck ? "checkmark.circle.fill" : "circle")

                    Text("Mujer")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: ¿Como consideras que eres?
            Text("¿Como consideras que eres?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.activoCheck = true
                viewModel.tranquiloCheck = !viewModel.activoCheck
                viewModel.ambosCheck = !viewModel.activoCheck

            } label: {
                HStack {
                    Image(systemName: viewModel.activoCheck ? "checkmark.circle.fill" : "circle")

                    Text("Activo")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.tranquiloCheck = true
                viewModel.activoCheck = !viewModel.tranquiloCheck
                viewModel.ambosCheck = !viewModel.tranquiloCheck

            } label: {
                HStack {
                    Image(systemName: viewModel.tranquiloCheck ? "checkmark.circle.fill" : "circle")

                    Text("Tranquilo")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.ambosCheck = true
                viewModel.tranquiloCheck = !viewModel.ambosCheck
                viewModel.activoCheck = !viewModel.ambosCheck

            } label: {
                HStack {
                    Image(systemName: viewModel.ambosCheck ? "checkmark.circle.fill" : "circle")

                    Text("50/50")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: ¿Prefieres un ambiente tranquilo o más social en casa?
            Text("¿Prefieres un ambiente tranquilo o más social en casa?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.ambienteSocialCheck = true
                viewModel.ambienteTranquiloCheck = !viewModel.ambienteSocialCheck

            } label: {
                HStack {
                    Image(systemName: viewModel.ambienteSocialCheck ? "checkmark.circle.fill" : "circle")

                    Text("Social")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.ambienteTranquiloCheck = true
                viewModel.ambienteSocialCheck = !viewModel.ambienteTranquiloCheck

            } label: {
                HStack {
                    Image(systemName: viewModel.ambienteTranquiloCheck ? "checkmark.circle.fill" : "circle")

                    Text("Tranquilo")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: ¿Qué te gusta hacer en tu tiempo libre?
            Text("¿Qué te gusta hacer en tu tiempo libre?")
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.tiempoLibre, axis: .vertical)
            .onSubmit {
                focusedField = .descripcion
            }
            .lineLimit(2)
            .textFieldStyle(.plain)
            .focused($focusedField, equals: .tiempoLibre)

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

            //MARK: ¿Sueles fumar en tu dia a dia?
            Text("¿Sueles fumar en tu dia a dia?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.fumarCheck = true
            } label: {
                HStack {
                    Image(systemName: viewModel.fumarCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.fumarCheck = false

            } label: {
                HStack {
                    Image(systemName: viewModel.fumarCheck ? "circle" : "checkmark.circle.fill")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: ¿Te gusta salir mucho de fiesta?
            Text("¿Te gusta salir mucho de fiesta?")
                .customFont(font: .boldFont, size: 14)
                .padding(.bottom, 5)

            Button {
                viewModel.fiestaCheck = true
            } label: {
                HStack {
                    Image(systemName: viewModel.fiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                viewModel.fiestaCheck = false
            } label: {
                HStack {
                    Image(systemName: viewModel.fiestaCheck ? "circle" : "checkmark.circle.fill")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.bottom, 16)

            //MARK: Descríbete para conocerte más:
            Text("Descríbete para conocerte más:")
                .customFont(font: .boldFont, size: 14)

            TextField("", text: $viewModel.descripcion, axis: .vertical)
                .lineLimit(3)
                .textFieldStyle(.plain)
                .focused($focusedField, equals: .descripcion)
                .toolbar {
                    if focusedField == .descripcion {
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Spacer()
                                Button("Fin") {
                                    focusedField = nil
                                }
                            }
                        }
                    }
                }

            Divider()
                .frame(height: 1)
                .overlay(Color.gray.opacity(0.7))
                .padding(.bottom, 16)

        }
        .padding(.init(top: 40, leading: 16, bottom: 0, trailing: 16))
    }

    private var buttonLabel: some View {
        //MARK: BOTON GUARDAR
        Button(action: {
            viewModel.comprobarFields { success in
                if success {
                    if viewModel.firstTime {
                        viewModel.navigationCheck = true
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }

        }) {
            Text("Guardar")
                .customFont(font: .boldFont, size: 15)
                .frame(width: 92, height: 36)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))
        }
    }

    private var vistaAnteriorButton: some View {
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
    CreacionPerfilView(CreacionPerfilViewModel())
}
