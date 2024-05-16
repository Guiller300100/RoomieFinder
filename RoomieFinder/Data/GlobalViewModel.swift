//
//  GlobalViewModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 12/5/24.
//

import Foundation
class GlobalViewModel: ObservableObject {
    static let shared = GlobalViewModel()

    @Published var fromLogin: Bool = true

    //Info de los demas perfiles
    @Published var users = [Usuario]()
    @Published var anuncios = [Anuncio]()

    //CurrentUser
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

    func getCurrentUserAd() {
        FirestoreUtils.getDataCurrentUser(collection: .Anuncios) { snapshot in
            if let snapshot = snapshot {

                self.misAnuncios = []
                self.misAnuncios = snapshot.documents.map{ d in
                    return Anuncio(
                        id: d.documentID,
                        userID: d["userID"] as? String ?? "",
                        barrio: d["barrio"] as? String ?? "",
                        tiempoEstancia: d["tiempoEstancia"] as? String ?? "",
                        presupuesto: d["presupuesto"] as? String ?? "",
                        num_hab: d["num_hab"] as? String ?? ""
                    )
                }
                print("Recogido los datos del Anuncio")
            }
        }
    }

    func deleteData(collection: CollectionType, documentId: String) {

        FirestoreUtils.deleteData(collection: collection, documentId: documentId) { error in
            if error != nil {
                print("elemento borrado")
            }
        }
    }

    func getAllUsers() {
        FirestoreUtils.getDataNotCurrentUser(collection: .Perfiles) { snapshot in
            if let snapshot = snapshot {

                self.users = []
                self.users = snapshot.documents.map{ d in
                    let idiomasStrings = d["idiomas"] as? [String] ?? []
                    // Convierte los strings a instancias de enum Idiomas
                    let idiomasEnum: Set<Idiomas> = Set(idiomasStrings.compactMap { Idiomas(rawValue: $0) })

                    return Usuario(
                        id: d.documentID,
                        userID: d["userID"] as? String ?? "",
                        nombre: d["nombre"] as? String ?? "",
                        apellido: d["apellido"] as? String ?? "",
                        fnac: d["fnac"] as? String ?? "",
                        info: Info(
                            estudios: d["estudios"] as? String ?? "",
                            universidad: d["universidad"] as? String ?? "",
                            idiomas: idiomasEnum,
                            sexo: d["sexo"] as? String ?? "",
                            tipoPersona: d["tipoPersona"] as? String ?? "",
                            ambiente: d["ambiente"] as? String ?? "",
                            tiempoLibre: d["tiempoLibre"] as? String ?? "",
                            fumar: d["fumar"] as? Bool ?? false,
                            fiesta: d["fiesta"] as? Bool ?? false,
                            descripcion: d["descripcion"] as? String ?? "",
                            urlImage: d["url"] as? String ?? ""
                        )
                    )
                }
                print("Recogido los datos de los usuarios")
            }
        }
    }

    func getDataCurrentUser() {
        var usuario = [Usuario]()
        FirestoreUtils.getDataCurrentUser(collection: .Perfiles) { snapshot in
            if let snapshot = snapshot {

                usuario = snapshot.documents.map{ d in
                    let idiomasStrings = d["idiomas"] as? [String] ?? []
                    // Convierte los strings a instancias de enum Idiomas
                    let idiomasEnum: Set<Idiomas> = Set(idiomasStrings.compactMap { Idiomas(rawValue: $0) })

                    return Usuario(
                        id: d.documentID,
                        userID: d["userID"] as? String ?? "",
                        nombre: d["nombre"] as? String ?? "",
                        apellido: d["apellido"] as? String ?? "",
                        fnac: d["fnac"] as? String ?? "",
                        info: Info(
                            estudios: d["estudios"] as? String ?? "",
                            universidad: d["universidad"] as? String ?? "",
                            idiomas: idiomasEnum,
                            sexo: d["sexo"] as? String ?? "",
                            tipoPersona: d["tipoPersona"] as? String ?? "",
                            ambiente: d["ambiente"] as? String ?? "",
                            tiempoLibre: d["tiempoLibre"] as? String ?? "",
                            fumar: d["fumar"] as? Bool ?? false,
                            fiesta: d["fiesta"] as? Bool ?? false,
                            descripcion: d["descripcion"] as? String ?? "",
                            urlImage: d["url"] as? String ?? ""
                        )
                    )
                }
            }
            self.currentUser = usuario.first!
        }
        print("Recogido los datos de usuario")
    }

    func getAllAds() {
        FirestoreUtils.getDataNotCurrentUser(collection: .Anuncios) { snapshot in
            if let snapshot = snapshot {

                self.anuncios = []
                self.anuncios = snapshot.documents.map{ d in
                    return Anuncio(
                        id: d.documentID,
                        userID: d["userID"] as? String ?? "",
                        barrio: d["barrio"] as? String ?? "",
                        tiempoEstancia: d["tiempoEstancia"] as? String ?? "",
                        presupuesto: d["presupuesto"] as? String ?? "",
                        num_hab: d["num_hab"] as? String ?? ""
                    )
                }
                print("Recogido los datos de los Anuncios")
            }
        }
    }
}
