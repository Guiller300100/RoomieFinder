//
//  HomeView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var perfilList: [Perfil]?
    @State var anunciosPisos: [AnuncioPisos]?
    @State private var selection = 0
    
    init(_ viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        
        switch viewModel.state {
        case .error, .unknownError:
            VStack {
                Text("Here your custom Error view")
            }
            
            
        case .empty:
            VStack {
                Text("Here your custom Empty View")
            }
            
        case .okey, .loading:
            NavigationStack {
                TabView(selection: $selection) {
                    PersonasView(PersonasViewModel(), perfilList ?? [])
                        .tabItem {
                            Image(systemName: selection == 0 ? "person.3.fill" : "person.3")
                                .environment(\.symbolVariants, .none)
                            Text("Personas")
                                .customFont(.mediumFont, size: 12)
                            
                        }
                        .tag(0)
                    
                    PisosView(PisosViewModel(), anunciosPisos ?? [])
                        .tabItem {
                            Image(systemName: selection == 1 ? "house.lodge.fill" : "house.lodge")
                                .environment(\.symbolVariants, .none)
                            Text("Casas")
                                .customFont(.mediumFont, size: 12)
                            
                        }
                        .tag(1)
                    BusquedaView(BusquedaViewModel())
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
                    MensajesView(MensajesViewModel())
                        .tabItem {
                            Image(systemName: selection == 3 ? "message.fill" : "message")
                                .environment(\.symbolVariants, .none)
                            Text("Mensajes")
                                .customFont(.mediumFont, size: 12)
                        }
                        .tag(3)
                    PerfilView(PerfilViewModel())
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
                .onAppear {
                    self.viewModel.onAppear()
                }
                .loaderBase(state: self.viewModel.state)
            }
        }
        
    }
    
    func cargarDatos() async {
        if let filePath = Bundle.main.url(forResource: "Perfiles", withExtension: "json"){
            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                self.perfilList = try decoder.decode([Perfil].self, from: data)
            } catch {
                print("Error cargando datos desde JSON: \(error)")
                self.perfilList = []
            }
        }
        
        if let filePath = Bundle.main.url(forResource: "AnunciosPisos", withExtension: "json"){
            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                self.anunciosPisos = try decoder.decode([AnuncioPisos].self, from: data)
            } catch {
                print("Error cargando datos desde JSON: \(error)")
                self.anunciosPisos = []
            }
        }
    }
}



#Preview {
    HomeView(HomeViewModel())
}
