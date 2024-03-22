//
//  PerfilRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 21/3/24.
//

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
                        .font(.custom(Constants.mediumFont, size: 14))
                        .lineLimit(nil)
                    Text("- Presupuesto: \(perfil.presupuesto ?? 0)€")
                        .font(.custom(Constants.regularFont, size: 12))
                        .padding(.top, 0.5)
                    Text("- Zona \(perfil.barrio ?? "")")
                        .font(.custom(Constants.regularFont, size: 12))
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



struct PerfilCell_Previews: PreviewProvider {
    static var previews: some View {
        PerfilRow(perfil: Perfil(id: 1, nombre: "Lydia", edad: 23, presupuesto: 500, barrio: "Parquesol", favorito: false))
            .previewLayout(.sizeThatFits)
    }
}
