//
//  CreacionPerfilView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct CreacionPerfilView: View {
    @StateObject var viewModel: CreacionPerfilViewModel
    @FocusState private var focusedField: CreacionType?

    init(_ viewModel: CreacionPerfilViewModel) {
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
            VStack {
                TopBarView()
                ScrollView {
                    
                    VStack {
                        Text("Creación de perfil")
                            .customFont(.mediumFont, size: 24)
                            .foregroundStyle(Constants.mainColor)
                            .padding(.init(top: 55, leading: 15, bottom: 15, trailing: 15))
                        
                        
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
                    
                    VStack(alignment: .leading) {
                        //MARK: ¿Qué estudias o que vas a estudiar?
                        Text("¿Qué estudias o que vas a estudiar?")
                            .customFont(.boldFont, size: 14)
                        
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
                            .customFont(.boldFont, size: 14)
                        
                        TextField("", text: $viewModel.universidad, onCommit: {
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
                            .customFont(.boldFont, size: 14)
                            .padding(.bottom, 5)
                        
                        Button {
                            viewModel.hombreCheck = true
                            viewModel.mujerCheck = !viewModel.hombreCheck
                            
                        } label: {
                            HStack {
                                Image(systemName: viewModel.hombreCheck ? "checkmark.circle.fill" : "circle")
                                
                                Text("Hombre")
                                    .customFont(.regularFont, size: 14)
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
                            viewModel.activoCheck = true
                            viewModel.tranquiloCheck = !viewModel.activoCheck
                            viewModel.ambosCheck = !viewModel.activoCheck
                            
                        } label: {
                            HStack {
                                Image(systemName: viewModel.activoCheck ? "checkmark.circle.fill" : "circle")
                                
                                Text("Activo")
                                    .customFont(.regularFont, size: 14)
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
                                    .customFont(.regularFont, size: 14)
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
                            viewModel.ambienteSocialCheck = true
                            viewModel.ambienteTranquiloCheck = !viewModel.ambienteSocialCheck
                            
                        } label: {
                            HStack {
                                Image(systemName: viewModel.ambienteSocialCheck ? "checkmark.circle.fill" : "circle")
                                
                                Text("Social")
                                    .customFont(.regularFont, size: 14)
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
                                    .customFont(.regularFont, size: 14)
                                    .foregroundStyle(.black)
                            }
                            
                        }
                        .padding(.bottom, 16)
                        
                        //MARK: ¿Qué te gusta hacer en tu tiempo libre?
                        Text("¿Qué te gusta hacer en tu tiempo libre?")
                            .customFont(.boldFont, size: 14)
                        
                        TextField("", text: $viewModel.tiempoLibre, onCommit: {
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
                            viewModel.fumarSiCheck = true
                            viewModel.fumarNoCheck = !viewModel.fumarSiCheck
                            
                        } label: {
                            HStack {
                                Image(systemName: viewModel.fumarSiCheck ? "checkmark.circle.fill" : "circle")
                                
                                Text("Si")
                                    .customFont(.regularFont, size: 14)
                                    .foregroundStyle(.black)
                            }
                            
                        }
                        
                        Button {
                            viewModel.fumarNoCheck = true
                            viewModel.fumarSiCheck = !viewModel.fumarNoCheck
                            
                        } label: {
                            HStack {
                                Image(systemName: viewModel.fumarNoCheck ? "checkmark.circle.fill" : "circle")
                                
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
                            viewModel.fiestaSiCheck = true
                            viewModel.fiestaNoCheck = !viewModel.fiestaSiCheck
                            
                        } label: {
                            HStack {
                                Image(systemName: viewModel.fiestaSiCheck ? "checkmark.circle.fill" : "circle")
                                
                                Text("Si")
                                    .customFont(.regularFont, size: 14)
                                    .foregroundStyle(.black)
                            }
                            
                        }
                        
                        Button {
                            viewModel.fiestaNoCheck = true
                            viewModel.fiestaSiCheck = !viewModel.fiestaNoCheck
                            
                        } label: {
                            HStack {
                                Image(systemName: viewModel.fiestaNoCheck ? "checkmark.circle.fill" : "circle")
                                
                                Text("No")
                                    .customFont(.regularFont, size: 14)
                                    .foregroundStyle(.black)
                            }
                            
                        }
                        .padding(.bottom, 16)
                        
                        //MARK: Descríbete para conocerte más:
                        Text("Descríbete para conocerte más:")
                            .customFont(.boldFont, size: 14)
                        
                        TextField("", text: $viewModel.descripcion, onCommit: {
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
                        //viewModel.comprobarField()
                        viewModel.navigationCheck = true
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
            .alert(isPresented: $viewModel.alertPushCreacionPerfil, content: {
                Alert(title: Text(viewModel.alertTitleCreacionPerfil), message: Text(viewModel.alertMessageCreacionPerfil), dismissButton: .default(Text("Vale")))
            })
            
            .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
                PhotoPicker.init(avatarImage: $viewModel.avatarImage)
            })
            
            .navigationDestination(isPresented: $viewModel.navigationCheck, destination: {
                CreacionAnuncioView(CreacionAnuncioViewModel())
                    .navigationBarBackButtonHidden(true)
            })
            .onAppear {
                self.viewModel.onAppear()
            }
            .loaderBase(state: self.viewModel.state)
        }
        
    }
}

#Preview {
    CreacionPerfilView(CreacionPerfilViewModel())
}
