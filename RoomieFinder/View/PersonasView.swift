//
//  PersonasView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct PersonasView: View {

    var PerfilList: [Perfil]?
    @State private var isShowed: Bool = false

    var body: some View {

        VStack {
            TopBarView()
            ScrollView {
                VStack {
                    Text("Inicio")
                        .font(.custom(Constants.mediumFont, size: 24))
                        .foregroundStyle(Constants.mainColor)
                        .padding(.top, 15)

                    if let PerfilListDes = PerfilList {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                            ForEach(PerfilListDes) { perfil in
                                PerfilRow(perfil: perfil)
                                    .onTapGesture {
                                        isShowed = true
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .halfASheet(isPresented: $isShowed, title: "Prueba HalfSheet") {
            Text("Me ha salido perfecto")
        }
    }
}

#Preview {
    PersonasView()
}
