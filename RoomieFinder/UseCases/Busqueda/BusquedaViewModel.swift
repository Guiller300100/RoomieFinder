//
//  BusquedaViewModel.swift
//
//  Created on 9/4/24
//

import Foundation

public class BusquedaViewModel: ObservableObject {

    @Published var filtrosNavegacion: Bool = false
    @Published var isShowed: Bool = false
    @Published var anuncioSeleccionado: Anuncio?
    @Published var isTapped: Bool = false

    public func onAppear() {
    }


}
