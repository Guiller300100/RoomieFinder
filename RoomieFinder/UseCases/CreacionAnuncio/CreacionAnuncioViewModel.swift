//
//  CreacionAnuncioViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

public class CreacionAnuncioViewModel: ObservableObject {



    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared
    
    //VARIABLES
    @Published var direccion = ""
    @Published var tiempoAlquiler = ""
    @Published var precio = ""
    @Published var numHabitaciones = ""
    @Published var firstTime: Bool

    //RADIOBUTTONS
    @Published var pisoCheck = false

    //NAVIGATION CHECK
    @Published var navigationCheck = false
    
    //ALERTAS
    @Published var alertPushCreacionAnuncio = false
    @Published var alertTitleCreacionAnuncio: String = ""
    @Published var alertMessageCreacionAnuncio: String = ""

    var anuncioSelected: Anuncio?

    init(
        firstTime: Bool,
        anuncioSelected: Anuncio? = nil
    ){
        self.firstTime = firstTime
        self.anuncioSelected = anuncioSelected
    }

    
    func comprobarFields(completion: @escaping (Bool) -> Void) {

        if direccion.isEmpty || tiempoAlquiler.isEmpty || precio.isEmpty || ( pisoCheck && numHabitaciones.isEmpty)  {
            
            alertTitleCreacionAnuncio = "Campos vacíos"
            alertMessageCreacionAnuncio = "Por favor, completa todos los campos."
            alertPushCreacionAnuncio = true
            
        } else {

            //TODO: COMPROBAR SI ANUNCIOSELECTED ES NULO O NO, YA QUE SI NO ES NULO ES HACER UN UPDATE

            self.addData { error in
                if error != nil {
                    print("error al subir los datos")
                } else {
                    self.getDataAd()
                    if self.firstTime {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
        
    }

    func addData(completion: @escaping (Error?) -> Void) {


        DispatchQueue.main.async { [self] in
            FirestoreUtils.addData(
                collection: .Anuncios,
                documentData: [
                    "userID": globalViewModel.currentUser.userID,
                    "barrio": direccion,
                    "tiempoEstancia": tiempoAlquiler,
                    "presupuesto": precio,
                    "num_hab": numHabitaciones
                ]
            ) { error in
                if let error = error {
                    print("Error update data:", error)
                    completion(error)
                } else {
                    print("Data update successfully")
                    completion(nil)
                }
            }

        }
    }


    func getDataAd() {
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
            }
        }
        print("Recogido los datos del Anuncio")
    }

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

        // TODO: HACER ESTO CUANDO CARGUE LA FOTO DE PERFIL
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.getPhoto()
//        }
    }
    
//    func getPhoto() {
//
//        guard let currentUser = Auth.auth().currentUser else {return}
//
//        let user = globalViewModel.users.first { $0.userID == currentUser.uid }
//
//
//        let storageRef = Storage.storage().reference()
//        let fileRef = storageRef.child(user!.info.urlImage)
//
//        DispatchQueue.main.async {
//            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                if let error = error {
//                    print("Error getting image data: \(error)")
//                } else if let data = data {
//                    if let image = UIImage(data: data) {
//                        self.avatarImage = image
//                    } else {
//                        print("Error creating UIImage from data")
//                    }
//                } else {
//                    print("No data received")
//                }
//            }
//        }
//    }
    
    public func onAppear() {
        if firstTime {
            getDataUser()
        }

        if anuncioSelected != nil {
            direccion = anuncioSelected!.barrio
            tiempoAlquiler = anuncioSelected!.tiempoEstancia
            precio = anuncioSelected!.presupuesto
            if !anuncioSelected!.num_hab.isEmpty {
                pisoCheck = true
                numHabitaciones = anuncioSelected!.num_hab
            }
        }



    }
    
    public func actionFromView() {
        // Example of private method
    }
    
    
}



enum AnuncioFieldType {
    case direccion
    case tiempo
    case presupuesto
    case habitaciones
}
