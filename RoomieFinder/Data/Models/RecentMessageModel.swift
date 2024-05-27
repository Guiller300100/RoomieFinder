//
//  RecentMessageModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 27/5/24.
//

import Foundation
import Firebase

struct RecentMessageModel: Identifiable {
    var id: String { documentId }
    let documentId: String
    let fromId: String
    let toId: String
    let text: String
    let nombre: String
    let apellido: String
    let photo: String
    let timestamp: Timestamp

    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data[Constants.Firebase.fromId] as? String ?? ""
        self.toId = data[Constants.Firebase.toId] as? String ?? ""
        self.text = data[Constants.Firebase.text] as? String ?? ""
        self.nombre = data["nombre"] as? String ?? ""
        self.apellido = data["apellido"] as? String ?? ""
        self.photo = data["profileImage"] as? String ?? ""
        self.timestamp = data[Constants.Firebase.timestamp] as? Timestamp ?? Timestamp(date: Date())
    }
}
