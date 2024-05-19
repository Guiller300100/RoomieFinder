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
    @Published var firstTime: Bool
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

    public init(firstTime: Bool = true) {
        self.firstTime = firstTime
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

    func comprobarFields(completion: @escaping (Bool) -> Void) {

        if estudios.isEmpty || universidad.isEmpty || idiomas.isEmpty || (!hombreCheck && !mujerCheck) || (!activoCheck && !tranquiloCheck && !ambosCheck) || (!ambienteSocialCheck && !ambienteTranquiloCheck) || tiempoLibre.isEmpty || descripcion.isEmpty {

            alertTitleCreacionPerfil = "Campos vacíos"
            alertMessageCreacionPerfil = "Por favor, completa todos los campos."
            alertPushCreacionPerfil = true
            completion(false)

        }  else {
            self.addData { error in
                if let error = error {
                    print(error)
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }

    }

    func addData(completion: @escaping (Error?) -> Void) {


        prepareData()

        if photoPath.isEmpty {
            uploadPhoto()
        }

        var data = [String: Any]()
        if firstTime {
            data = [
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
                "url": photoPath
            ]
        } else {
            data = [
                "estudios": estudios,
                "universidad": universidad,
                "idiomas": idiomasArray,
                "sexo": sexo,
                "tipoPersona": tipoPersona,
                "ambiente": ambiente,
                "tiempoLibre": tiempoLibre,
                "fumar": fumarCheck,
                "fiesta": fiestaCheck,
                "descripcion": descripcion
            ]
        }

        DispatchQueue.main.async { [self] in
            FirestoreUtils.updateData(
                collection: .Perfiles,
                documentId: globalViewModel.currentUser.id,
                documentData: data
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
            ambiente = "social"
        } else if ambienteTranquiloCheck {
            ambiente = "tranquilo"
        }

        let idiomasStrings = idiomas.map { $0.rawValue }

        idiomasArray = idiomasStrings
    }

    private func modificarInfo() {
        estudios = globalViewModel.currentUser.info.estudios
        universidad = globalViewModel.currentUser.info.universidad
        idiomas = globalViewModel.currentUser.info.idiomas

        if globalViewModel.currentUser.info.sexo == "hombre" {
            hombreCheck = true
        } else if globalViewModel.currentUser.info.sexo == "mujer"{
            mujerCheck = true
        }


        if globalViewModel.currentUser.info.tipoPersona == "activo" {
            activoCheck = true
        } else if globalViewModel.currentUser.info.tipoPersona == "tranquilo" {
            tranquiloCheck = true
        } else {
            ambosCheck = true
        }

        if globalViewModel.currentUser.info.ambiente == "social" {
            ambienteSocialCheck = true
        } else if globalViewModel.currentUser.info.ambiente == "tranquilo" {
            ambienteTranquiloCheck = true
        }

        tiempoLibre = globalViewModel.currentUser.info.tiempoLibre

        if globalViewModel.currentUser.info.fumar {
            fumarCheck = true
        } else {
            fumarCheck = false
        }

        if globalViewModel.currentUser.info.fiesta {
            fiestaCheck = true
        } else {
            fiestaCheck = false
        }

        descripcion = globalViewModel.currentUser.info.descripcion

    }

    public func onAppear() {
        if !globalViewModel.currentUser.info.urlImage.isEmpty {
            firstTime = false
            modificarInfo()
        } else {
            firstTime = true
        }

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
