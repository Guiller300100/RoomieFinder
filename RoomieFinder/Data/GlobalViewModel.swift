//
//  GlobalViewModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 12/5/24.
//

import Foundation
import Firebase

class GlobalViewModel: ObservableObject {
    static let shared = GlobalViewModel()
    
    @Published var fromLogin: Bool = true
    
    //Info de los demas perfiles
    @Published var users = [Usuario]()
    @Published var anuncios = [Anuncio]()
    @Published var favoritos = [Favoritos]()
    
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
            trabaja: false,
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
    
    // Almacenar los anuncios filtrados
    @Published var anunciosFiltrados = [Anuncio]()
    
    // MARK: PARTE DE FILTROSVIEW
    @Published var hombreCheck = false
    @Published var mujerCheck = false
    @Published var fumadorCheck = false
    @Published var noFumadorCheck = false
    @Published var fiestaCheck = false
    @Published var noFiestaCheck = false
    @Published var estudianteCheck = false
    @Published var trabajadorCheck = false
    @Published var activoCheck = false
    @Published var tranquiloCheck = false
    @Published var ambosCheck = false
    @Published var españolCheck = false
    @Published var inglesCheck = false
    @Published var francesCheck = false
    @Published var portuguesCheck = false
    @Published var alemanCheck = false
    @Published var italianoCheck = false
    @Published var isToggleOn = false

    //ALERTAS
    @Published var alertPush = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""

    //COMPROBACION
    @Published var correctChecks: Bool = false

    func comprobarCheck() {
        if (hombreCheck && mujerCheck) || (fumadorCheck && noFumadorCheck) || (fiestaCheck && noFiestaCheck) || (estudianteCheck && trabajadorCheck) || (activoCheck && tranquiloCheck && ambosCheck) || (españolCheck && inglesCheck && francesCheck && portuguesCheck && alemanCheck && italianoCheck) {
            correctChecks = false
            alertTitle = "Error en filtros"
            alertMessage = "Por favor, no selecciones todas las opciones de una categoria. Si quieres que salgan todas, deja las opciones de esa categoria sin seleccionar."
            alertPush = true
        } else {
            aplicarFiltros()
            correctChecks = true
        }
    }

    func limpiarFiltros() {

        hombreCheck = false
        mujerCheck = false
        fumadorCheck = false
        noFumadorCheck = false
        fiestaCheck = false
        noFiestaCheck = false
        estudianteCheck = false
        trabajadorCheck = false
        activoCheck = false
        tranquiloCheck = false
        ambosCheck = false
        españolCheck = false
        inglesCheck = false
        francesCheck = false
        portuguesCheck = false
        alemanCheck = false
        italianoCheck = false

        // Aplica filtros sin ninguno seleccionado
        aplicarFiltros()

    }

    func deleteFav() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        FirestoreUtils.deleteData(collection: .Favoritos, documentId: currentUser.uid) { error in
            if let error = error {
                print("Error delete data:", error)
                // Maneja el error aquí (mostrar mensaje de error, reintentar, etc.)
            } else {
                print("Data delete successfully")
                // Realiza acciones posteriores a la adición exitosa (actualiza UI, etc.)
            }
        }
        
        getFav()
    }
    
    func updateFav(userFavID: String) {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        
        FirestoreUtils.updateFav(collection: .Favoritos, documentId: currentUser.uid, documentData: ["currentUser": currentUser.uid, "userFavID": userFavID]) { error in
            if let error = error {
                print("Error delete data:", error)
                // Maneja el error aquí (mostrar mensaje de error, reintentar, etc.)
            } else {
                print("Data update successfully")
                // Realiza acciones posteriores a la adición exitosa (actualiza UI, etc.)
            }
        }
        
        getFav()
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
    
    func getFav() {
        
        FirestoreUtils.getData(collection: "Favoritos") { snapshot in
            if let snapshot = snapshot {
                self.favoritos = []
                self.favoritos = snapshot.documents.map{ d in
                    return Favoritos(
                        id: d.documentID,
                        currentUser: d["currentUser"] as? String ?? "",
                        favUserID: d["userFavID"] as? String ?? "")
                }
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
                            trabaja: d["trabaja"] as? Bool ?? false,
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
                            trabaja: d["trabaja"] as? Bool ?? false,
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

                    self.aplicarFiltros()

            }
        }
    }
    
    // Método para aplicar filtros
    func aplicarFiltros() {
        self.anunciosFiltrados = self.anuncios.filter { anuncio in
            guard let user = self.users.first(where: { $0.userID == anuncio.userID }) else {
                return false
            }

            // Aplica los filtros de género, hábitos y otros atributos del usuario
            if hombreCheck && user.info.sexo != "hombre" { return false }
            if mujerCheck && user.info.sexo != "mujer" { return false }
            if fumadorCheck && !user.info.fumar { return false }
            if noFumadorCheck && user.info.fumar { return false }
            if fiestaCheck && !user.info.fiesta { return false }
            if noFiestaCheck && user.info.fiesta { return false }
            if estudianteCheck && user.info.estudios.isEmpty { return false }
            if trabajadorCheck && !user.info.trabaja { return false }
            if activoCheck && user.info.ambiente != "activo" { return false }
            if tranquiloCheck && user.info.ambiente != "tranquilo" { return false }
            if ambosCheck && user.info.ambiente != "50/50" { return false }
            if españolCheck && !user.info.idiomas.contains(.español) { return false }
            if inglesCheck && !user.info.idiomas.contains(.ingles) { return false }
            if francesCheck && !user.info.idiomas.contains(.frances) { return false }
            if portuguesCheck && !user.info.idiomas.contains(.portugues) { return false }
            if alemanCheck && !user.info.idiomas.contains(.aleman) { return false }
            if italianoCheck && !user.info.idiomas.contains(.italiano) { return false }

            if isToggleOn {
                return favoritos.contains { $0.favUserID == user.userID }
            }

            return true
        }
    }

}
