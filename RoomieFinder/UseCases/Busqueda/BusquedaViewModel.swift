//
//  BusquedaViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class BusquedaViewModel: ObservableObject {

    @Published var filtrosNavegacion: Bool = false
    @Published var isShowed: Bool = false
    @Published var perfilSeleccionado: Perfil?
    @Published var isTapped: Bool = false
    @Published var perfilList: [Perfil] = []

    public func onAppear() {
        perfilList = self.cargarDatos()
    }
    
    func cargarDatos() -> [Perfil] {
      var listaPerfiles: [Perfil] = []

      if let filePath = Bundle.main.url(forResource: "Perfiles", withExtension: "json") {
        DispatchQueue.global(qos: .userInitiated).async {
          do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            listaPerfiles = try decoder.decode([Perfil].self, from: data)
          } catch {
            print("Error cargando datos desde JSON: \(error)")
          }

          // Actualizar la interfaz de usuario en el hilo principal
          DispatchQueue.main.async {
            self.perfilList = listaPerfiles
          }
        }
      }

      return listaPerfiles
    }

    func delete() {
        perfilList.removeLast()
    }

}
