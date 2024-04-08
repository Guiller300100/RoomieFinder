//
//  PisosView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct PisosView: View {

    var Anuncios_Pisos: [AnuncioPisos]?
    @State private var isShowed: Bool = false
    @State private var pisoSeleccionado: AnuncioPisos?

    var body: some View {
        VStack {
            TopBarView()
            HStack {
                Button(action: {
                    
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Constants.mainColor)
                }

                Spacer()

                Text("Pisos")
                    .customFont(.mediumFont, size: 24)
                    .offset(x: 20)
                    .foregroundStyle(Constants.mainColor)

                Spacer()

                Image(systemName: "list.bullet")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Constants.mainColor)

                Divider()
                    .overlay(Rectangle().foregroundStyle(Constants.mainColor))

                Image(systemName: "map.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Constants.mainColor)

            }
            .frame(height: 25)
            .padding(.all, 15)


            ScrollView {
                if let Anuncios_PisosDes = Anuncios_Pisos {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(Anuncios_PisosDes) { piso in
                            PisoRow(piso: piso)
                                .onTapGesture {
                                    pisoSeleccionado = piso
                                }
                        }
                    }
                    .padding(.horizontal)
                }

            }
            .frame(maxHeight: .infinity)
        }

//        .sheet(isPresented: $isShowed) {
//            if let piso = pisoSeleccionado {
//
//                PerfilDetailView(perfil: piso)
//                    .presentationDetents([.fraction(0.75)])
//            }
//        }

    }
}

#Preview {
    PisosView()
}
