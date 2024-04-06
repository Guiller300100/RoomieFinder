//
//  CreacionPerfilViewModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 6/4/24.
//

import Foundation
import Firebase

extension CreacionPerfilView {

    @MainActor class CreacionPerfilViewModel: ObservableObject {
        
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
        @Published var fumarSiCheck = false
        @Published var fumarNoCheck = false
        @Published var fiestaSiCheck = false
        @Published var fiestaNoCheck = false




        //IMAGE PICKER STATES
        @Published var avatarImage = UIImage(named: "DefaultAvatarImage")!
        @Published var isShowingPhotoPicker = false

        //NAVIGATION CHECK
        @Published var navigationCheck = false

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
}
