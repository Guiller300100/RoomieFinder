//
//  PersonasViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class PersonasViewModel: ObservableObject {
    @Published var perfilList: [Perfil] = []
    
    public func onAppear() {
        perfilList = self.cargarDatos()
    }
    
    public func actionFromView() {
        // Example of private method
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


}
