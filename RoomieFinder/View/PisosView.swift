//
//  PisosView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct PisosView: View {
    var body: some View {
        VStack {
            TopBarView()

            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Constants.mainColor)

                        Spacer()

                            Text("Pisos")
                                .font(.custom(Constants.mediumFont, size: 24))
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
                    .padding(.all, 15)
                }
            }
        }
    }
}

#Preview {
    PisosView()
}
