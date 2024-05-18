//
//  PerfilViewModel.swift
//
//  Created on 9/4/24
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

public class PerfilViewModel: ObservableObject {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    //IMAGE PICKER STATES
    @Published var avatarImage = UIImage(named: "DefaultAvatarImage")!
    @Published var isShowingPhotoPicker = false

    //NAVIGATION CHECK
    @Published var navigationAnunciosCheck = false
    @Published var navigationInfoPerfilCheck = false

    //VARIABLES
    var photoPath = ""

    func uploadPhoto() {

        // Create storage reference
        let storageRef = Storage.storage().reference()

        // Turn our image into data
        guard let imageData = avatarImage.jpegData(compressionQuality: 1) else {
            return
        }

        // Specify the file path and name
        let path = "images/\(globalViewModel.currentUser.userID).jpg"
        let fileRef = storageRef.child(path)

        // Upload that data
        _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            // Check for errors
            if let error = error {
                print("Error uploading data: \(error)")
            } else {
                // Data uploaded successfully, call the completion handler with the path
                self.photoPath = path
                print("Added the photo to Storage with path: \(self.photoPath)")

                self.getPhoto()
//                self.updateDataPhoto { error in
//                    if error != nil {
//                        print("Error update data:", error!)
//                    } else {
//
//                    }
//                }
            }
        }
    }

//    func updateDataPhoto(completion: @escaping (Error?) -> Void) {
//
//        FirestoreUtils.updateData(collection: .Perfiles, documentId: globalViewModel.currentUser.id, documentData: ["url": photoPath]) { error in
//            if let error = error {
//                completion(error)
//            } else {
//                print("Data update successfully")
//                completion(nil)
//            }
//        }
//    }

    func getPhoto() {
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(globalViewModel.currentUser.info.urlImage)

        DispatchQueue.main.async {
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error getting image data: \(error)")
                } else if let data = data {
                    if let image = UIImage(data: data) {
                        self.avatarImage = image
                    } else {
                        print("Error creating UIImage from data")
                    }
                } else {
                    print("No data received")
                }
            }
        }
    }


    public func onAppear() {
        globalViewModel.getDataCurrentUser()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.getPhoto()
        }

    }

    public func actionFromView() {
        // Example of private method
    }

}

