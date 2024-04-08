//
//  Main.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 20/3/24.
//

import SwiftUI

struct MainView: View {
    @State var PerfilList: [Perfil]?
    @State var Anuncios_Pisos: [AnuncioPisos]?
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            PersonasView(PerfilList: PerfilList)
                .tabItem {
                    Image(systemName: selection == 0 ? "person.3.fill" : "person.3")
                        .environment(\.symbolVariants, .none)
                    Text("Personas")
                        .customFont(.mediumFont, size: 12)

                }
                .tag(0)

            PisosView(Anuncios_Pisos: Anuncios_Pisos)
                .tabItem {
                    Image(systemName: selection == 1 ? "house.lodge.fill" : "house.lodge")
                        .environment(\.symbolVariants, .none)
                    Text("Casas")
                        .customFont(.mediumFont, size: 12)

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
                        .customFont(.mediumFont, size: 12)
                }
                .tag(2)
            MensajesView()
                .tabItem {
                    Image(systemName: selection == 3 ? "message.fill" : "message")
                        .environment(\.symbolVariants, .none)
                    Text("Mensajes")
                        .customFont(.mediumFont, size: 12)
                }
                .tag(3)
            PerfilView()
                .tabItem {
                    Image(systemName: selection == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                    Text("Perfil")
                        .customFont(.mediumFont, size: 12)
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
        if let filePath = Bundle.main.url(forResource: "Perfiles", withExtension: "json"){
            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                self.PerfilList = try decoder.decode([Perfil].self, from: data)
            } catch {
                print("Error cargando datos desde JSON: \(error)")
                self.PerfilList = []
            }
        }

        if let filePath = Bundle.main.url(forResource: "AnunciosPisos", withExtension: "json"){
            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                self.Anuncios_Pisos = try decoder.decode([AnuncioPisos].self, from: data)
            } catch {
                print("Error cargando datos desde JSON: \(error)")
                self.Anuncios_Pisos = []
            }
        }
    }
}

#Preview {
    MainView()
}
