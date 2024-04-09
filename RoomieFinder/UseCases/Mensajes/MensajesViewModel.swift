//
//  MensajesViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class MensajesViewModel: BaseViewModel, ObservableObject {
    var business = MensajesBusiness()
    var state: ViewModelState = .okey
    var showWarningError = false
    @Published var modelView: MensajesModelView
    var dto: MensajesDTO?
    @Published var isToggleOn = false

    init(dto: MensajesDTO? = nil) {
        self.dto = dto
        self.modelView = MensajesModelView(modelBusiness: nil)
    }
    
    public func onAppear() {
    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

struct MensajesDTO {
    // Añadir propiedades del DTO si fuese necesario
}
