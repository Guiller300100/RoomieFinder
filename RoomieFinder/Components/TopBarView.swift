//
//  ContentView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {

        VStack {
            HStack {
                Text(Constants.titulo)
                    .font(.custom(Constants.mediumFont, size: 24))
                Spacer()

                Button(action: {

                }, label: {
                    Text("Cerrar Sesión")
                        .font(.custom(Constants.boldFont, size: 14))

                })
                .frame(width: 130, height: 36)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))


            }
            .padding(.init(top: 5, leading: 19, bottom: 0, trailing: 10))
            Divider()
                .frame(height: 1)
                .overlay(Constants.mainColor.opacity(0.7))
        }
    }
}

#Preview {
    TopBarView()
}
