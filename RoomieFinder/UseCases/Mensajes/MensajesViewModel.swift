//
//  MensajesViewModel.swift
//
//  Created on 9/4/24
//

import SwiftUI
import Firebase

public class MensajesViewModel: ObservableObject {
    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared
    @Published var errorMessage = ""
    @Published var recentMessages = [RecentMessageModel]()
    @Published var chatNavigation = false
    @Published var chatSeleccionado: RecentMessageModel?


    private func fetchRecentMessages() {
        let uid = globalViewModel.currentUser.userID

        Firestore.firestore()
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for recent messages: \(error)"
                    print(error)
                    return
                }

                querySnapshot?.documentChanges.forEach({ change in
                    let docId = change.document.documentID

                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.documentId == docId
                    }) {
                        self.recentMessages.remove(at: index)

                    }

                    self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
                })
            }
    }

    public func onAppear() {
        fetchRecentMessages()
    }

    public func actionFromView() {
        // Example of private method
    }

}

