//
//  BusquedaViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import SwiftUI

public class BusquedaViewModel: ObservableObject {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    @Published var filtrosNavegacion: Bool = false
    @Published var chatNavegacion: Bool = false
    @Published var isShowed: Bool = false
    @Published var anuncioSeleccionado: Anuncio?
    @Published var isTapped: Bool = false

    public func onAppear() {
        globalViewModel.getAllAds()
        globalViewModel.getAllUsers()

    }


}
