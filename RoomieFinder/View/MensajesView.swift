//
//  MensajesView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct MensajesView: View {

    @State private var isToggleOn = false

    var body: some View {
        VStack {
            TopBarView()

            ScrollView {
                VStack {
                    HStack {

                        Spacer()
                        Text("Mensajes")
                            .font(.custom(Constants.mediumFont, size: 24))
                            .offset(x: 40)
                            .foregroundStyle(Constants.mainColor)

                        Spacer()

                        if isToggleOn {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .trailing)
                                .foregroundStyle(.yellow)
                        } else {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .trailing)
                                .foregroundStyle(.gray)
                        }

                        Toggle(isOn: $isToggleOn){
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Constants.mainColor))
                        .labelsHidden()
                    }
                    .padding(.all, 15)
                }
            }
        }
    }
}
#Preview {
    MensajesView()
}
