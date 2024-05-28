//
//  ChatLogViewModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 23/5/24.
//

import Foundation
import Firebase
import SwiftUI

class ChatLogViewModel: ObservableObject {

    @Published var message: String = ""
    @Published var errorMessage: String = ""
    @Published var chatMessages = [ChatMessageModel]()
    @Published var count: Int = 0

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    let toUser: Usuario

    init(
        toUser: Usuario
    ) {
        self.toUser = toUser

        fetchMessages()
    }

    private func fetchMessages() {

        let fromId = globalViewModel.currentUser.userID

        let toId = toUser.userID

        Firestore.firestore().collection("Chats")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener {
                querySnapshot,
                error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    print(error)
                    return
                }

                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })

                DispatchQueue.main.async {
                    self.count += 1
                }
            }
    }

    func handleSend() {
        let fromId = globalViewModel.currentUser.userID

        let toId = toUser.userID

        let document = Firestore.firestore().collection("Chats").document(fromId).collection(toId).document()

        let messageData = [Constants.Firebase.fromId: fromId, Constants.Firebase.toId: toId, Constants.Firebase.text: self.message, Constants.Firebase.timestamp: Timestamp()] as [String : Any]

        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            print("Successfully saved current User sending message")


            self.persistRecentMessage()

            self.message = ""
            self.count += 1
        }

        let recipientMessageDocument =
        Firestore.firestore()
            .collection("Chats")
            .document(toId)
            .collection(fromId)
            .document()

        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            print("Recipient saved message as well")
        }
    }

    func persistRecentMessage() {

        let uid = globalViewModel.currentUser.userID

        let toId = toUser.userID

        let document = Firestore.firestore()
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .document(toId)

        let data = [
            Constants.Firebase.timestamp : Timestamp(),
            Constants.Firebase.text : self.message,
            Constants.Firebase.fromId : uid,
            Constants.Firebase.toId : toId,
            "profileImage": toUser.info.urlImage,
            "nombre" : toUser.nombre,
            "apellido" : toUser.apellido
        ] as [String : Any]

        document.setData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to save recente message: \(error)"
                print("Failed to save recente message: \(error)")
                return
            }
        }

        let recipientRecentMessageDictionary = [
            Constants.Firebase.timestamp : Timestamp(),
            Constants.Firebase.text : self.message,
            Constants.Firebase.fromId : uid,
            Constants.Firebase.toId : toId,
            "profileImage": globalViewModel.currentUser.info.urlImage,
            "nombre" : globalViewModel.currentUser.nombre,
            "apellido" : globalViewModel.currentUser.apellido
        ] as [String : Any]

        Firestore.firestore()
            .collection("recent_messages")
            .document(toId)
            .collection("messages")
            .document(uid)
            .setData(recipientRecentMessageDictionary) { error in
                if let error = error {
                    print("Failed to save recipient recent message: \(error)")
                    return
                }
            }
    }
    
    private func scrollDown() {
        self.count += 1
    }
}
