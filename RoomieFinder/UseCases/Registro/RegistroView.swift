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
        
        switch viewModel.state {
        case .error, .unknownError:
            VStack {
                Text("Here your custom Error view")
            }
            
            
        case .empty:
            VStack {
                Text("Here your custom Empty View")
            }
            
        case .okey, .loading:
            NavigationStack {
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
                                .customFont(.boldFont, size: 14)
                            
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
                                    .customFont(.boldFont, size: 14)
                            }
                            
                            Divider()
                                .frame(height: 1)
                                .overlay(Color.gray.opacity(0.7))
                                .padding(.init(top: 10, leading: 0, bottom: 16, trailing: 0))
                            
                            Text("Correo electrónico:")
                                .customFont(.boldFont, size: 14)
                            
                            TextField("Correo electrónico", text: $viewModel.correoElectronico, onCommit: {
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
                            
                            SecureField("Contraseña", text: $viewModel.passwordInput, onCommit: {
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
                                viewModel.estudianteCheck = true
                                viewModel.PropietarioCheck = !viewModel.estudianteCheck
                                
                            } label: {
                                HStack {
                                    Image(systemName: viewModel.estudianteCheck ? "checkmark.circle.fill" : "circle")
                                    
                                    Text("Estudiante")
                                        .customFont(.regularFont, size: 14)
                                        .foregroundStyle(.black)
                                }
                                
                            }
                            
                            Button {
                                viewModel.PropietarioCheck = true
                                viewModel.estudianteCheck = !viewModel.PropietarioCheck
                                
                            } label: {
                                HStack {
                                    Image(systemName: viewModel.PropietarioCheck ? "checkmark.circle.fill" : "circle")
                                    
                                    Text("Propietario")
                                        .customFont(.regularFont, size: 14)
                                        .foregroundStyle(.black)
                                }
                                
                            }
                            
                        }
                        
                        Button(action: {
                            viewModel.comprobarFields()
                        }) {
                            Text("Registrarse")
                                .customFont(.boldFont, size: 15)
                                .frame(width: 130, height: 36)
                                .foregroundStyle(.white)
                                .background(Constants.mainColor)
                                .clipShape(RoundedRectangle(cornerRadius: 999))
                        }
                        
                    }
                    
                    
                    .alert(isPresented: $viewModel.alertPushRegistro, content: {
                        Alert(title: Text(viewModel.alertTitleRegistro), message: Text(viewModel.alertMessageRegistro), dismissButton: .default(Text("Vale")))
                    })
                    
                    .navigationDestination(isPresented: $viewModel.isRegistred, destination: {
                        CreacionPerfilView(CreacionPerfilViewModel())
                            .navigationBarBackButtonHidden(true)
                    })
                    .padding(.horizontal)
                    
                }
            }
            .onAppear {
                self.viewModel.onAppear()
            }
            .loaderBase(state: self.viewModel.state)
        }
        
    }
}

#Preview {
    RegistroView(RegistroViewModel())
}
