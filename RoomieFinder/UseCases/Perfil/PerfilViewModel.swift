//
//  PerfilViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import UIKit

public class PerfilViewModel: ObservableObject {

    //IMAGE PICKER STATES
    @Published var avatarImage = UIImage(named: "DefaultAvatarImage")!
    @Published var isShowingPhotoPicker = false

    //NAVIGATION CHECK
    @Published var navigationCheck = false


    
    public func onAppear() {

    }
    
    public func actionFromView() {
        // Example of private method
    }
    
}

