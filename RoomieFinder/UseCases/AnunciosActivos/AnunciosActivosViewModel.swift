//
//  AnunciosActivosViewModel.swift
//
//  Created on 20/4/24
//

import Foundation
import SwiftUI

public class AnunciosActivosViewModel: ObservableObject {

    //Array de datos
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    @Published var anuncioSelected: Anuncio?


    @Published var isNavigatedNew: Bool = false
    @Published var isNavigatedModified: Bool = false

    public func onAppear() {
        globalViewModel.getCurrentUserAd()
    }

    
}
