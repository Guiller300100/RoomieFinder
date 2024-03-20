//
//  BusquedaView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct BusquedaView: View {
    var body: some View {
        VStack {
            TopBarView()
            
            ScrollView {
                VStack {
                    Text("Búsqueda")
                        .font(.custom(Constants.mediumFont, size: 24))
                        .foregroundStyle(Constants.mainColor)
                        .padding(.top, 15)
                }
            }
        }
    }
}

#Preview {
    BusquedaView()
}
