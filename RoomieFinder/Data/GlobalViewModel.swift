//
//  GlobalViewModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 12/5/24.
//

import Foundation
class GlobalViewModel: ObservableObject {
    static let shared = GlobalViewModel()

    @Published var users = [Usuario]()
//    @Published var pisos = [Pisos]()
//    @Published var favoritos = [Favoritos]()

    private init() {
        // Inicializa tus datos globales aquí si es necesario
    }
}
