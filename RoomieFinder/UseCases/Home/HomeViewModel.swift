//
//  HomeViewModel.swift
//
//  Created on 9/4/24
//

import Foundation


public class HomeViewModel: BaseViewModel, ObservableObject {
    var business = HomeBusiness()
    var state: ViewModelState = .okey
    var showWarningError = false
    @Published var modelView: HomeModelView
    var dto: HomeDTO?
    
    init(dto: HomeDTO? = nil) {
        self.dto = dto
        self.modelView = HomeModelView(modelBusiness: nil)
    }
    
    public func onAppear() {
        
    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

struct HomeDTO {
    // Añadir propiedades del DTO si fuese necesario
}
