//
//  ChatMessageModel.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 25/5/24.
//

import Foundation
import Firebase

struct ChatMessageModel: Identifiable {
    var id: String { documentId }

    let documentId: String
    let fromId: String
    let toId: String
    let text: String
    let timestamp: Timestamp

    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data[Constants.Firebase.fromId] as? String ?? ""
        self.toId = data[Constants.Firebase.toId] as? String ?? ""
        self.text = data[Constants.Firebase.text] as? String ?? ""
        self.timestamp = data[Constants.Firebase.timestamp] as? Timestamp ?? Timestamp()
    }
}
