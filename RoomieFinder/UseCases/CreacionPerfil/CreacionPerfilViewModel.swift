//
//  CreacionPerfilViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import Firebase
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

            addData()

            navigationCheck = true

        }


    }

    func addData() {

        guard let currentUser = Auth.auth().currentUser else {return}
        guard let profile = globalViewModel.users.first(where: { $0.userID == currentUser.uid }) else {return}

        FirestoreUtils.updateData(collection: .Perfiles, documentId: profile.id, documentData: ["Prueba": "prueba"]) { error in
            if let error = error {
                print("Error update data:", error)
                // Maneja el error aquí (mostrar mensaje de error, reintentar, etc.)
            } else {
                print("Data update successfully")
                // Realiza acciones posteriores a la adición exitosa (actualiza UI, etc.)
            }
        }

    }

    public func onAppear() {

        print(globalViewModel.users)

        //let profile = globalViewModel.users.first(where: { $0.userID == "1" })



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
