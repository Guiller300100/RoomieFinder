//
//  HomeViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import SwiftUI
import Firebase


public class HomeViewModel: ObservableObject {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared


    func getDataUser() {
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
            self.globalViewModel.currentUser = usuario.first!
        }
        print("Recogido los datos de usuario")
    }

    func getCurrentUserAd() {
        FirestoreUtils.getDataCurrentUser(collection: .Anuncios) { snapshot in
            if let snapshot = snapshot {

                self.globalViewModel.misAnuncios = []
                self.globalViewModel.misAnuncios = snapshot.documents.map{ d in
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

    func getAllAds() {
        FirestoreUtils.getDataNotCurrentUser(collection: .Anuncios) { snapshot in
            if let snapshot = snapshot {

                self.globalViewModel.anuncios = []
                self.globalViewModel.anuncios = snapshot.documents.map{ d in
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

//    func getAllUsers(completion: @escaping (Error?) -> Void) {
//        FirestoreUtils.getDataNotCurrentUser(collection: .Perfiles) { snapshot in
//            if let snapshot = snapshot {
//
//                var users: [Usuario] = []
//                for document in snapshot.documents {
//                    if let user = self.parseUsuario(document: document) {
//                        users.append(user)
//                    }
//                }
//                self.globalViewModel.users = users
//                print("Recogido los datos de los usuarios")
//            }
//        }
//    }

    public func onAppear() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Constants.mainColor) // Cambia el color de los TabItems no seleccionados
        getDataUser()
        getCurrentUserAd()
        getAllAds()
    }



    public func actionFromView() {
        // Example of private method
    }

}

struct HomeDTO {
    // Añadir propiedades del DTO si fuese necesario
}
