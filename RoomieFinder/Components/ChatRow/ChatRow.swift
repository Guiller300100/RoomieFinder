//
//  ChatRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 23/5/24.
//

import SwiftUI
import FirebaseStorage
import Firebase

struct ChatRow: View {

    let recentMessage: RecentMessageModel

    @State private var avatarImage: UIImage?

    var body: some View {
        messageView
            .onAppear() {
                    getPhoto { photo in
                        avatarImage = photo
                    }
            }
    }

    private var messageView: some View {
        HStack(spacing: 16) {
            Image(uiImage: (avatarImage ?? UIImage(named: "DefaultAvatarImage")!))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Constants.mainColor, lineWidth: 2)
                )



            VStack(alignment: .leading, spacing: 8) {
                Text("\(recentMessage.nombre) \(recentMessage.apellido)")
                    .customFont(font: .boldFont, size: 16)
                Text(recentMessage.text)
                    .customFont(font: .regularFont, size: 14, color: Color(.lightGray))
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
    }

    private func getPhoto(completion: @escaping (UIImage?) -> Void) {
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(recentMessage.photo)

        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error getting image data: \(error)")
                    completion(nil)
                } else if let data = data {
                    if let image = UIImage(data: data) {
                        completion(image)
                    } else {
                        print("Error creating UIImage from data")
                        completion(nil)
                    }
                } else {
                    print("No data received")
                    completion(nil)
                }
            }
        }
    }
}



#Preview {
    ChatRow(
        recentMessage: RecentMessageModel(
            documentId: "Kz43o9LCEHXtSWwrBuEPOn6Yo2W2",
            data: [
                "timestamp" : Timestamp(),
                "fromId" : "Kz43o9LCEHXtSWwrBuEPOn6Yo2W2",
                "toId" : "zC7E0fQHi7bL0TUh3tUoXVWDnjq2"
            ]
        )
    )
}
