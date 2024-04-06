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
        //IMAGE PICKER STATES
        @Published var avatarImage = UIImage(named: "DefaultAvatarImage")!
        @Published var isShowingPhotoPicker = false
    }
}
