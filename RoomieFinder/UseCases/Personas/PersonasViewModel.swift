//
//  PersonasViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class PersonasViewModel: BaseViewModel, ObservableObject {
    var business = PersonasBusiness()
    var state: ViewModelState = .okey
    var showWarningError = false
    @Published var modelView: PersonasModelView
    var dto: PersonasDTO?
    
    init(dto: PersonasDTO? = nil) {
        self.dto = dto
        self.modelView = PersonasModelView(modelBusiness: nil)
    }
    
    public func onAppear() {
    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

struct PersonasDTO {
    // Añadir propiedades del DTO si fuese necesario
}
