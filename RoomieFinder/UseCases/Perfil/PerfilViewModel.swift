//
//  PerfilViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import UIKit

public class PerfilViewModel: BaseViewModel, ObservableObject {
    var business = PerfilBusiness()
    var state: ViewModelState = .okey
    var showWarningError = false
    @Published var modelView: PerfilModelView
    var dto: PerfilDTO?

    //IMAGE PICKER STATES
    @Published var avatarImage = UIImage(named: "DefaultAvatarImage")!
    @Published var isShowingPhotoPicker = false

    init(dto: PerfilDTO? = nil) {
        self.dto = dto
        self.modelView = PerfilModelView(modelBusiness: nil)
    }
    
    public func onAppear() {

    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

struct PerfilDTO {
    // Añadir propiedades del DTO si fuese necesario
}
