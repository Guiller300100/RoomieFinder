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
    
    //RADIOBUTTONS
    @Published var pisoSiCheck = false
    @Published var pisoNoCheck = true
    
    //NAVIGATION CHECK
    @Published var navigationCheck = false
    
    //ALERTAS
    @Published var alertPushCreacionAnuncio = false
    @Published var alertTitleCreacionAnuncio: String = ""
    @Published var alertMessageCreacionAnuncio: String = ""

    
    func comprobarFields() {
        
        if direccion.isEmpty || tiempoAlquiler.isEmpty || precio.isEmpty || ( pisoSiCheck && numHabitaciones.isEmpty)  {
            
            alertTitleCreacionAnuncio = "Campos vacíos"
            alertMessageCreacionAnuncio = "Por favor, completa todos los campos."
            alertPushCreacionAnuncio = true
            
        } else {
            
            navigationCheck = true
        }
        
    }
    func getData() {
        FirestoreUtils.getData(collection: .Perfiles) { snapshot in
            if let snapshot = snapshot {
                
                self.globalViewModel.users = []
                self.globalViewModel.users = snapshot.documents.map{ d in
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
        }
        print("Recogido los datos")

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
        getData()

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
