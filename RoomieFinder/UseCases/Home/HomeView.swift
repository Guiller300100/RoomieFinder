//
//  HomeView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct HomeView: View {
    // MARK: Variables
    @StateObject var viewModel: HomeViewModel
    @State private var selection = 0
    
    init(_ viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    // MARK: body
    var body: some View {
        TabView(selection: $selection) {
            PersonasView(PersonasViewModel())
                .tabItem {
                    Image(systemName: selection == 0 ? "person.3.fill" : "person.3")
                        .environment(\.symbolVariants, .none)
                    Text("Personas")
                        .customFont(.mediumFont, size: 12)
                    
                }
                .tag(0)
            BusquedaView(BusquedaViewModel())
                .tabItem {
                    if selection == 1 {
                        Image("magnifyingglass")
                            .font(.system(size: 30, weight: .heavy))
                            .environment(\.symbolVariants, .none)
                    } else {
                        Image(systemName: "magnifyingglass")
                            .environment(\.symbolVariants, .none)
                    }
                    Text("Busqueda")
                        .customFont(.mediumFont, size: 12)
                }
                .tag(1)
            MensajesView(MensajesViewModel())
                .tabItem {
                    Image(systemName: selection == 2 ? "message.fill" : "message")
                        .environment(\.symbolVariants, .none)
                    Text("Mensajes")
                        .customFont(.mediumFont, size: 12)
                }
                .tag(2)
            PerfilView(PerfilViewModel())
                .tabItem {
                    Image(systemName: selection == 3 ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                    Text("Perfil")
                        .customFont(.mediumFont, size: 12)
                }
                .tag(3)
        }
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Constants.mainColor) // Cambia el color de los TabItems no seleccionados
        }
    }
}



#Preview {
    HomeView(HomeViewModel())
}
