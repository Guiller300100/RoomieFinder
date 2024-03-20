//
//  Main.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            PersonasView()
                .tabItem {
                    Image(systemName: selection == 0 ? "person.3.fill" : "person.3")
                        .environment(\.symbolVariants, .none)
                    Text("Personas")
                        .font(.custom(Constants.mediumFont, size: 12))
                }
                .tag(0)
            
            PisosView()
                .tabItem {
                    Image(systemName: selection == 1 ? "house.fill" : "house")
                        .environment(\.symbolVariants, .none)
                    Text("Casas")
                        .font(.custom(Constants.mediumFont, size: 12))
                }
                .tag(1)
            BusquedaView()
                .tabItem {
                    if selection == 2 {
                        Image("magnifyingglass")
                            .font(.system(size: 30, weight: .heavy))
                            .environment(\.symbolVariants, .none)
                    } else {
                        Image(systemName: "magnifyingglass")
                            .environment(\.symbolVariants, .none)
                    }
                    Text("Busqueda")
                        .font(.custom(Constants.mediumFont, size: 12))
                }
                .tag(2)
            MensajesView()
                .tabItem {
                    Image(systemName: selection == 3 ? "message.fill" : "message")
                        .environment(\.symbolVariants, .none)
                    Text("Mensajes")
                        .font(.custom(Constants.mediumFont, size: 12))
                }
                .tag(3)
            PerfilView()
                .tabItem {
                    Image(systemName: selection == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                    Text("Perfil")
                        .font(.custom(Constants.mediumFont, size: 12))
                }
                .tag(4)
        }
        .accentColor(Constants.mainColor) // Cambia el color de los TabItems seleccionados
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Constants.mainColor) // Cambia el color de los TabItems no seleccionados
        }
    }
}

#Preview {
    MainView()
}
