//
//  FirestoreUtils.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 9/5/24.
//

import Foundation
import Firebase

class FirestoreUtils {
    
    private static let db = Firestore.firestore()
    
    // Función estática para añadir datos
    static func addData(collection: CollectionType, documentData: [String: Any], completion: @escaping (Error?) -> Void) {
            db.collection(collection.rawValue).addDocument(data: documentData) { error in
                completion(error)
        }
    }
    
    // Función estática para obtener datos
    static func getData(collection: CollectionType, completion: @escaping (QuerySnapshot?) -> Void) {
        db.collection(collection.rawValue).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil)
                print("Error fetching data:", error)
            } else {
                completion(querySnapshot)
            }
        }
    }

    // Función estática para obtener datos solo del usuario
    static func getDataCurrentUser(collection: CollectionType, completion: @escaping (QuerySnapshot?) -> Void) {

        guard let currentUser = Auth.auth().currentUser else {return}
        db.collection(collection.rawValue).whereField("userID", isEqualTo: currentUser.uid).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil)
                print("Error fetching data:", error)
            } else {
                completion(querySnapshot)
            }
        }
    }

    // Función estática para actualizar datos
    static func updateData(collection: CollectionType, documentId: String, documentData: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection(collection.rawValue).document(documentId).updateData(documentData) { error in
            completion(error)
        }
    }
    
    // Función estática para eliminar datos
    static func deleteData(collection: CollectionType, documentId: String, completion: @escaping (Error?) -> Void) {
        db.collection(collection.rawValue).document(documentId).delete { error in
            completion(error)
        }
    }

    // Función estática para obtener datos de todas las colecciones
        static func getAllData(completion: @escaping (Bool) -> Void) {
            getData(collection: .Perfiles) { querySnapshot in
                guard let querySnapshot = querySnapshot else {
                    completion(false)
                    return
                }
                var users: [Usuario] = []
                for document in querySnapshot.documents {
                    if let user = parseUsuario(document: document) {
                        users.append(user)
                    }
                }
                GlobalViewModel.shared.users = users
                getData(collection: .Anuncios) { querySnapshot in
                    guard let querySnapshot = querySnapshot else {
                        completion(false)
                        return
                    }
                    var anuncios: [Anuncio] = []
                    for document in querySnapshot.documents {
                        if let anuncio = parseAnuncio(document: document) {
                            anuncios.append(anuncio)
                        }
                    }
                    GlobalViewModel.shared.anuncios = anuncios
                    completion(true)
                }
            }
        }

        // Función para parsear documentos de usuario
        static func parseUsuario(document: QueryDocumentSnapshot) -> Usuario? {
            guard
                let id = document["id"] as? String,
                let userID = document["userID"] as? String,
                let nombre = document["nombre"] as? String,
                let apellido = document["apellido"] as? String,
                let fnac = document["fnac"] as? String,
                let infoDict = document["info"] as? [String: Any],
                let info = parseInfo(infoDict: infoDict)
            else {
                return nil
            }
            return Usuario(id: id, userID: userID, nombre: nombre, apellido: apellido, fnac: fnac, info: info)
        }

        // Función para parsear información de usuario
        static func parseInfo(infoDict: [String: Any]) -> Info? {
            guard
                let estudios = infoDict["estudios"] as? String,
                let universidad = infoDict["universidad"] as? String,
                let idiomasDict = infoDict["idiomas"] as? [String: Bool],
                let sexo = infoDict["sexo"] as? String,
                let tipoPersona = infoDict["tipoPersona"] as? String,
                let ambiente = infoDict["ambiente"] as? String,
                let tiempoLibre = infoDict["tiempoLibre"] as? String,
                let fumar = infoDict["fumar"] as? Bool,
                let fiesta = infoDict["fiesta"] as? Bool,
                let descripcion = infoDict["descripcion"] as? String,
                let urlImage = infoDict["urlImage"] as? String
            else {
                return nil
            }

            var idiomas: Set<Idiomas> = []
            for (idioma, value) in idiomasDict {
                if value {
                    if let idiomaEnum = Idiomas(rawValue: idioma) {
                        idiomas.insert(idiomaEnum)
                    }
                }
            }

            return Info(estudios: estudios, universidad: universidad, idiomas: idiomas, sexo: sexo, tipoPersona: tipoPersona, ambiente: ambiente, tiempoLibre: tiempoLibre, fumar: fumar, fiesta: fiesta, descripcion: descripcion, urlImage: urlImage)
        }

        // Función para parsear documentos de anuncio
        static func parseAnuncio(document: QueryDocumentSnapshot) -> Anuncio? {
            guard
                let id = document["id"] as? String,
                let userID = document["userID"] as? String,
                let barrio = document["barrio"] as? String,
                let tiempoEstancia = document["tiempoEstancia"] as? String,
                let presupuesto = document["presupuesto"] as? String,
                let num_hab = document["num_hab"] as? String
            else {
                return nil
            }
            return Anuncio(id: id, userID: userID, barrio: barrio, tiempoEstancia: tiempoEstancia, presupuesto: presupuesto, num_hab: num_hab)
        }
}
