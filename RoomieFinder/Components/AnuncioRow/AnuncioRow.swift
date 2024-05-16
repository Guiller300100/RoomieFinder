//
//  AnuncioRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 27/4/24.
//

import SwiftUI

struct AnuncioRow: View {

    let anuncio: Anuncio

    //Array de datos
    @StateObject var globalViewModel = GlobalViewModel.shared


    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(anuncio.barrio)")
                        .customFont(font: .mediumFont, size: 18)

                    VStack(alignment: .leading) {
                        Text("• Tiempo \(anuncio.tiempoEstancia)")
                            .customFont(font: .regularFont, size: 18)

                        Text(
                            anuncio.num_hab.isEmpty ? "• Presupuesto \(anuncio.presupuesto)": "• Precio \(anuncio.presupuesto)"
                        )
                            .customFont(font: .regularFont, size: 18)

                        if !anuncio.num_hab.isEmpty {
                            Text("• habitaciones: \(anuncio.num_hab)")
                                .customFont(font: .regularFont, size: 18)
                        }
                    }
                    .padding(.leading, 5)

                }
                Spacer()
            }
            .padding()

            buttonModifiedLabel
                .padding(.bottom, 5)

            buttonDeletedLabel
                .padding(.bottom, 5)

            Spacer()
        }
        .frame(width: 307, height: 212)
        .background(Color.second)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.all, 10)
    }


    private var buttonModifiedLabel: some View {
        Button(action: {

        }) {
            Text("Modificar anuncio")
                .customFont(font: .boldFont, size: 15)
                .frame(width: 148, height: 30)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))
        }
    }

    private var buttonDeletedLabel: some View {
        Button(action: {

            globalViewModel.deleteData(collection: .Anuncios, documentId: anuncio.id)

            globalViewModel.getCurrentUserAd()


        }) {
            Text("Eliminar anuncio")
                .customFont(font: .boldFont, size: 15)
                .frame(width: 148, height: 30)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))
        }
    }
}

#Preview {
    AnuncioRow(anuncio: Anuncio(id: "", userID: "", barrio: "Parquesol", tiempoEstancia: "4 meses", presupuesto: "300€", num_hab: "4"))
}
