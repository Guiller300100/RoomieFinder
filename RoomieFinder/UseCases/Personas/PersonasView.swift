//
//  PersonasView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct PersonasView: View {
    @StateObject var viewModel: PersonasViewModel
    @State private var isShowed: Bool = false
    @State private var perfilSeleccionado: Perfil?

    init(_ viewModel: PersonasViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            TopBarView()
            ScrollView {
                VStack {
                    Text("Inicio")
                        .customFont(font: .mediumFont, size: 24)
                        .foregroundStyle(Constants.mainColor)
                        .padding(.top, 15)


                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(viewModel.perfilList) { perfil in
                            PerfilRow(perfil: perfil)
                                .onTapGesture {
                                    // Delay the state updates to allow data retrieval
                                    //TODO: Esto no funciona bien
                                    DispatchQueue.main.async {
                                        self.perfilSeleccionado = perfil
                                        self.isShowed = true
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)

                }
            }
        }


        //MARK: - VISTA MODAL PERSONAS
        .sheet(isPresented: $isShowed) {
            if let perfil = perfilSeleccionado {
                PerfilDetailView(perfil: perfil)
                    .presentationDetents([.fraction(0.80)])
            }
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}

#Preview {
    PersonasView(PersonasViewModel())
}
