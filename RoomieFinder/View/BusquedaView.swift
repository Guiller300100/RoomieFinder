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
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        .foregroundStyle(Constants.mainColor)
                        Spacer()
                        Text("Búsqueda")
                            .font(.custom(Constants.mediumFont, size: 24))
                            .offset(x: -13)
                            .foregroundStyle(Constants.mainColor)
                        
                        Spacer()
                    }

                }
            }
        }
    }
}

#Preview {
    BusquedaView()
}
