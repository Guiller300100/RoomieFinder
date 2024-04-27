//
//  PerfilRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 27/4/24.
//

import Foundation
import SwiftUI

struct PerfilRow: View {

    @State private var isFavorited: Bool
    var perfil : Perfil

    init(perfil: Perfil) {
        self.perfil = perfil
        self._isFavorited = State(initialValue: perfil.favorito)
    }

    var body: some View {
        VStack {
            Image("Perfil")
                .resizable()
                .frame(width: 91, height: 71)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 13)



            HStack {
                VStack(alignment: .leading) {
                    Text("\(perfil.nombre ?? ""), \(perfil.edad ?? 0) años")
                        .customFont(font: .mediumFont, size: 14)
                        .lineLimit(nil)
                    Text("• Presupuesto: \(perfil.presupuesto ?? 0)€")
                        .customFont(font: .regularFont, size: 12)
                        .padding(.top, 0.5)
                    Text("• Zona \(perfil.barrio ?? "")")
                        .customFont(font: .regularFont, size: 12)
                    Spacer()
                }


                VStack {
                    Button(action: {
                        isFavorited.toggle()
                    }, label: {
                        if isFavorited {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .frame(width: 20, height: 18)
                        } else {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.gray)
                                .frame(width: 20, height: 18)
                        }
                    })
                    Spacer()
                }
            }

            Spacer()
        }
        .frame(width: 160, height: 190)
        .background(Color.second)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .onAppear {
            isFavorited = perfil.favorito
        }

    }
}
