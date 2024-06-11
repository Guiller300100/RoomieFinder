//
//  BusquedaView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct BusquedaView: View {
    @StateObject var viewModel: BusquedaViewModel

    //Array de datos
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    init(_ viewModel: BusquedaViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()

            VStack {
                ScrollView {
                    HStack {
                        Button {

                            viewModel.filtrosNavegacion = true

                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Constants.mainColor)
                        }

                        Spacer()

                        Text("Búsqueda")
                            .customFont(font: .mediumFont, size: 24)
                            .offset(x: -39)
                            .foregroundStyle(Constants.mainColor)


                        if globalViewModel.isToggleOn {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .trailing)
                                .foregroundStyle(.yellow)
                        } else {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .trailing)
                                .foregroundStyle(.gray)
                        }

                        Toggle(isOn: $globalViewModel.isToggleOn){
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Constants.mainColor))
                        .labelsHidden()
                    }
                    .frame(height: 25)
                    .padding(.all, 15)

                    if !globalViewModel.anunciosFiltrados.isEmpty {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                            ForEach(globalViewModel.anunciosFiltrados, id: \.id) { anuncio in
                                PerfilRow(anuncio: anuncio)
                                    .onTapGesture {
                                        DispatchQueue.main.async {
                                            self.viewModel.anuncioSeleccionado = anuncio
                                            self.viewModel.isTapped.toggle()
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        Text("Vaya! no hay ningún anuncio")
                            .customFont(font: .boldFont, size: 24)
                    }

                }
                .refreshable {
                    // Llama a las funciones para recargar datos
                    globalViewModel.limpiarFiltros()
                    globalViewModel.getAllUsers()
                    globalViewModel.getAllAds()

                }
            }
        }
        //MARK: - VISTA MODAL PERSONAS
        .sheet(isPresented: $viewModel.isShowed) {
            if let anuncio = viewModel.anuncioSeleccionado {
                let usuario = globalViewModel.users.first(where: { $0.userID == anuncio.userID })!
                PerfilDetailView(usuario: usuario, anuncio: anuncio, shouldNavigation: $viewModel.chatNavegacion, isShowed: $viewModel.isShowed)
                    .presentationDetents([.fraction(0.80)])
            } else {
                Text("No hay nombre")
            }
        }
        .onChange(of: self.viewModel.isTapped, perform: { newValue in
            self.viewModel.isShowed = true
        })
        .onChange(of: globalViewModel.isToggleOn) { newValue in
            // Llama a la función onAppear nuevamente para aplicar los filtros actualizados
            globalViewModel.aplicarFiltros()
        }

        .navigationDestination(isPresented: $viewModel.filtrosNavegacion, destination: {
            withAnimation {
                FiltrosView()
                    .navigationBarBackButtonHidden(true)
            }
        })

        .navigationDestination(isPresented: $viewModel.chatNavegacion, destination: {
            if let anuncio = viewModel.anuncioSeleccionado {
                let usuario = globalViewModel.users.first(where: { $0.userID == anuncio.userID })!
                withAnimation {
                    ChatLogView(toUser: usuario)
                }
            } else {
                Text("No hay nombre")
            }
        })
        .onAppear {
            self.viewModel.onAppear()
        }
    }


}

#Preview {
    BusquedaView(BusquedaViewModel())
}
