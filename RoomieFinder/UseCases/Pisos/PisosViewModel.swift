//
//  PisosViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class PisosViewModel: BaseViewModel, ObservableObject {
    var business = PisosBusiness()
    var state: ViewModelState = .okey
    var showWarningError = false
    @Published var modelView: PisosModelView
    var dto: PisosDTO?
    
    init(dto: PisosDTO? = nil) {
        self.dto = dto
        self.modelView = PisosModelView(modelBusiness: nil)
    }
    
    public func onAppear() {

    }
    
    public func actionFromView() {
        // Example of private method
    }

    
}

struct PisosDTO {
    // Añadir propiedades del DTO si fuese necesario
}
