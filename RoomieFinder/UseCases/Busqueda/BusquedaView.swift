//
//  BusquedaView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct BusquedaView: View {
    @StateObject var viewModel: BusquedaViewModel

    init(_ viewModel: BusquedaViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()

            ScrollView {
                VStack {
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
                            .offset(x: -13)
                            .foregroundStyle(Constants.mainColor)

                        Spacer()
                    }
                    .frame(height: 25)
                    .padding(.all, 15)


                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(viewModel.perfilList, id: \.id) { perfil in
                            PerfilRow(perfil: perfil)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        self.viewModel.perfilSeleccionado = perfil
                                        self.viewModel.isTapped.toggle()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        //MARK: - VISTA MODAL PERSONAS
        .sheet(isPresented: $viewModel.isShowed) {
            if let perfil = viewModel.perfilSeleccionado {
                PerfilDetailView(perfil: perfil)
                    .presentationDetents([.fraction(0.80)])
            } else {
                Text(self.viewModel.perfilSeleccionado?.nombre ?? "No hay nombre")
            }
        }
        .onChange(of: self.viewModel.isTapped, perform: { newValue in
            self.viewModel.isShowed = true
        })

        .navigationDestination(isPresented: $viewModel.filtrosNavegacion, destination: {
            withAnimation {
                FiltrosView()
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
