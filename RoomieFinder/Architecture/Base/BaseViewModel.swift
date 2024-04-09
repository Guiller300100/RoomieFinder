//
//  BaseViewModel.swift
//  MyEdex
//
//  Created by Raul Pascual de la Calle on 8/4/24.
//

import Foundation

protocol BaseViewModel: ObservableObject {
    var state: ViewModelState { get set }
    var showWarningError: Bool { get set }
    func onAppear()
}

extension BaseViewModel {
    func onAppear() {
    }
}

enum ViewModelState: String {
    case okey
    case loading
    case error
    case empty
    case unknownError
}
