//
//  BusquedaViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class BusquedaViewModel: BaseViewModel, ObservableObject {
    var business = BusquedaBusiness()
    var state: ViewModelState = .okey
    var showWarningError = false
    @Published var modelView: BusquedaModelView
    var dto: BusquedaDTO?
    
    init(dto: BusquedaDTO? = nil) {
        self.dto = dto
        self.modelView = BusquedaModelView(modelBusiness: nil)
    }
    
    public func onAppear() {

    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

struct BusquedaDTO {
    // Añadir propiedades del DTO si fuese necesario
}
