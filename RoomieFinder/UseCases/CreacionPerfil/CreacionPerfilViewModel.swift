//
//  CreacionPerfilViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

public class CreacionPerfilViewModel: ObservableObject {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    //VARIABLES
    @Published var estudios = ""
    @Published var universidad = ""
    @Published var idiomas = Set<Idiomas>()
    @Published var isMultiPickerOpen = false
    @Published var tiempoLibre = ""
    @Published var descripcion = ""

    //RADIOBUTTONS
    @Published var hombreCheck = false
    @Published var mujerCheck = false
    @Published var activoCheck = false
    @Published var tranquiloCheck = false
    @Published var ambosCheck = false
    @Published var ambienteSocialCheck = false
    @Published var ambienteTranquiloCheck = false
    @Published var fumarCheck = false
    @Published var fiestaCheck = false


    //VARIABLES
    var sexo = ""
    var tipoPersona = ""
    var ambiente = ""
    var idiomasArray = [String]()
    var photoPath = ""


    //IMAGE PICKER STATES
    @Published var avatarImage = UIImage(named: "DefaultAvatarImage")!
    @Published var isShowingPhotoPicker = false

    //NAVIGATION CHECK
    @Published var navigationCheck = false

    //ALERTAS
    @Published var alertPushCreacionPerfil = false
    @Published var alertTitleCreacionPerfil: String = ""
    @Published var alertMessageCreacionPerfil: String = ""


    func comprobarField() {

        if estudios.isEmpty || universidad.isEmpty || idiomas.isEmpty || (!hombreCheck && !mujerCheck) || (!activoCheck && !tranquiloCheck && !ambosCheck) || (!ambienteSocialCheck && !ambienteTranquiloCheck) || tiempoLibre.isEmpty || descripcion.isEmpty {

            alertTitleCreacionPerfil = "Campos vacíos"
            alertMessageCreacionPerfil = "Por favor, completa todos los campos."
            alertPushCreacionPerfil = true

        } else {

            self.addData(path: photoPath)

        }

    }

    func uploadPhoto() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }

        // Create storage reference
        let storageRef = Storage.storage().reference()

        // Turn our image into data
        guard let imageData = avatarImage.jpegData(compressionQuality: 1) else {
            return
        }

        // Specify the file path and name
        let path = "images/\(currentUser.uid).jpg"
        let fileRef = storageRef.child(path)

        // Upload that data
        _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            // Check for errors
            if let error = error {
                print("Error uploading data: \(error)")
            } else {
                // Data uploaded successfully, call the completion handler with the path
                self.photoPath = path
                print("Added the photo to Storage with path: \(self.photoPath)")
            }
        }
    }


    func prepareData() {
        if hombreCheck {
            sexo = "hombre"
        } else if mujerCheck {
            sexo = "mujer"
        }

        if activoCheck {
            tipoPersona = "activo"
        } else if tranquiloCheck {
            tipoPersona = "tranquilo"
        } else {
            tipoPersona = "ambos"
        }

        if ambienteSocialCheck {
            ambiente = "Social"
        } else if ambienteTranquiloCheck {
            ambiente = "Tranquilo"
        }

        let idiomasStrings = idiomas.map { $0.rawValue }

        idiomasArray = idiomasStrings


    }

    func addData(path: String) {

        guard let currentUser = Auth.auth().currentUser else {return}
        guard let profile = globalViewModel.users.first(where: { $0.userID == currentUser.uid }) else {return}


        prepareData()


        DispatchQueue.main.async { [self] in
            FirestoreUtils.updateData(
                collection: .Perfiles,
                documentId: profile.id,
                documentData: [
                    "estudios": estudios,
                    "universidad": universidad,
                    "idiomas": idiomasArray,
                    "sexo": sexo,
                    "tipoPersona": tipoPersona,
                    "ambiente": ambiente,
                    "tiempoLibre": tiempoLibre,
                    "fumar": fumarCheck,
                    "fiesta": fiestaCheck,
                    "descripcion": descripcion,
                    "url": path
                ]
            ) { error in
                if let error = error {
                    print("Error update data:", error)
                } else {
                    print("Data update successfully")
                }
            }

        }

        navigationCheck = true
    }

    public func onAppear() {

    }

    public func actionFromView() {
        // Example of private method
    }

}


enum CreacionType {
    case estudios
    case universidad
    case tiempoLibre
    case descripcion
}

enum Idiomas: String, CaseIterable {
    case Español
    case Inglés
    case Francés
    case Italiano
    case Portugués
    case Alemán
}
