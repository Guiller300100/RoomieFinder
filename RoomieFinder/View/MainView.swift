//
//  Main.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct MainView: View {
    @State var PerfilList: [Perfile]?
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            PersonasView(PerfilList: PerfilList)
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
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Constants.mainColor) // Cambia el color de los TabItems no seleccionados
        }
        .task {
            await self.cargarDatos()
        }
    }

    func cargarDatos() async {
        if let filePath = Bundle.main.url(forResource: "Prueba", withExtension: "json"){
            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                self.PerfilList = try decoder.decode([Perfile].self, from: data)
            } catch {
                print("Error cargando datos desde JSON: \(error)")
                self.PerfilList = []
            }
        }
    }
}

#Preview {
    MainView()
}
