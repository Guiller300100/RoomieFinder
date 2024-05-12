//
//  FirestoreUtils.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 9/5/24.
//

import Foundation
import Firebase

class FirestoreUtils {
    
    private static let db = Firestore.firestore()
    
    // Función estática para añadir datos
    static func addData(collection: CollectionType, documentData: [String: Any], completion: @escaping (Error?) -> Void) {
            db.collection(collection.rawValue).addDocument(data: documentData) { error in
                completion(error)
        }
    }
    
    // Función estática para obtener datos
    static func getData(collection: CollectionType, completion: @escaping (QuerySnapshot?) -> Void) {
        db.collection(collection.rawValue).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil)
                print("Error fetching data:", error)
            } else {
                completion(querySnapshot)
            }
        }
    }
    
    // Función estática para actualizar datos
    static func updateData(collection: CollectionType, documentId: String, documentData: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection(collection.rawValue).document(documentId).updateData(documentData) { error in
            completion(error)
        }
    }
    
    // Función estática para eliminar datos
    static func deleteData(collection: CollectionType, documentId: String, completion: @escaping (Error?) -> Void) {
        db.collection(collection.rawValue).document(documentId).delete { error in
            completion(error)
        }
    }
}
