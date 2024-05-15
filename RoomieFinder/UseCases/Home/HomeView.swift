//
//  HomeView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct HomeView: View {
    // MARK: Variables
    @StateObject var viewModel: HomeViewModel
    @State private var selection = 1

    init(_ viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    // MARK: body
    var body: some View {
        TabView(selection: $selection) {
            MensajesView(MensajesViewModel())
                .tabItem {
                    Image(systemName: selection == 0 ? "message.fill" : "message")
                        .environment(\.symbolVariants, .none)
                    Text("Mensajes")
                        .customFont(font: .mediumFont, size: 12)
                }
                .tag(0)
            BusquedaView(BusquedaViewModel())
                .tabItem {
                    if selection == 1 {
                        Image("magnifyingglass")
                            .font(.system(size: 30, weight: .heavy))
                    } else {
                        Image(systemName: "magnifyingglass")
                    }
                    Text("Busqueda")
                        .customFont(font: .mediumFont, size: 12)
                }
                .tag(1)
            PerfilView(PerfilViewModel())
                .tabItem {
                    Image(systemName: selection == 2 ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                    Text("Perfil")
                        .customFont(font: .mediumFont, size: 12)
                }
                .tag(2)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}



#Preview {
    HomeView(HomeViewModel())
}
