//
//  BusquedaView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct BusquedaView: View {
    @StateObject var viewModel: BusquedaViewModel

    init(_ viewModel: BusquedaViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()

            ScrollView {
                VStack {
                    HStack {
                        Button {

                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Constants.mainColor)
                        }
                        Spacer()
                        Text("Búsqueda")
                            .customFont(.mediumFont, size: 24)
                            .offset(x: -13)
                            .foregroundStyle(Constants.mainColor)

                        Spacer()
                    }
                    .frame(height: 25)
                    .padding(.all, 15)


                    Text("Prueba")
                }
            }
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }


}

#Preview {
    BusquedaView(BusquedaViewModel())
}
