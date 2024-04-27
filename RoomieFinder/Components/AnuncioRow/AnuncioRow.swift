//
//  AnuncioRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 27/4/24.
//

import SwiftUI

struct AnuncioRow: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Zona Parquesol")
                        .customFont(font: .mediumFont, size: 18)

                    VStack(alignment: .leading) {
                        Text("• Curso 23-24")
                            .customFont(font: .regularFont, size: 18)

                        Text("• _Presupuesto")
                            .customFont(font: .regularFont, size: 18)
                    }
                    .padding(.leading, 5)

                }
                Spacer()
            }
            .padding()

            buttonModifiedLabel
                .padding(.bottom, 5)

            buttonDeletedLabel

            Spacer()
        }
        .frame(width: 307, height: 212)
        .background(Color.second)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding()
    }


    private var buttonModifiedLabel: some View {
        Button(action: {
            //

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
            //

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
    AnuncioRow()
}
