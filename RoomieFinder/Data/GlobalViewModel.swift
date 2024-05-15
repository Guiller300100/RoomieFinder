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
    @Published var misAnuncios = [Anuncio]()
    @Published var currentUser: Usuario = Usuario(
        id: "",
        userID: "",
        nombre: "",
        apellido: "",
        fnac: "",
        info: Info(
            estudios: "",
            universidad: "",
            idiomas: Set<Idiomas>(),
            sexo: "",
            tipoPersona: "",
            ambiente: "",
            tiempoLibre: "",
            fumar: false,
            fiesta: false,
            descripcion: "",
            urlImage: ""
        )
    )

//    @Published var favoritos = [Favoritos]()

    private init() {

    }
}
