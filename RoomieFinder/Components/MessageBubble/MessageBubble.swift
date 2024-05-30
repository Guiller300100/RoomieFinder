//
//  MessageBubble.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 26/5/24.
//

import SwiftUI
import Firebase

struct MessageBubble: View {

    //Array de datos
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    let message: ChatMessageModel

    var body: some View {
        VStack {
            if message.fromId == globalViewModel.currentUser.userID {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        HStack {
                            Text(message.text)
                        }
                        .padding()
                        .background(Constants.secondaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Constants.mainColor, lineWidth: 1)
                        )

                        Text("\(formatTimestamp(message.timestamp))")
                            .customFont(font: .regularFont, size: 12, color: .gray)

                    }
                }
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(message.text)
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Constants.mainColor, lineWidth: 1)
                        )
                        Text("\(formatTimestamp(message.timestamp))")
                            .customFont(font: .regularFont, size: 12, color: .gray)
                    }

                    Spacer()
                }

            }
        }
        .padding(.horizontal)
        .padding(.top, 1)
    }

    private func formatTimestamp(_ timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        return dateFormatter.string(from: date)
    }
}


struct MessageBubble_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            MessageBubble(
                message: ChatMessageModel(
                    documentId: "4aSR3pSPzvxPJ7XrVdWY",
                    data: [
                        "fromId" : "zC7E0fQHi7bL0TUh3tUoXVWDnjq2",
                        "toId" : "Kz43o9LCEHXtSWwrBuEPOn6Yo2W2",
                        "text" : "bien he dormido bastante bien🫣",
                        "timestamp": Timestamp(date: Date())
                    ]
                )
            )


            MessageBubble(
                message: ChatMessageModel(
                    documentId: "4aSR3pSPzvxPJ7XrVdWY",
                    data: [
                        "fromId" : "zC7E0fQHi7bL0TUh3tUoXVWDnjq2",
                        "toId" : "Kz43o9LCEHXtSWwrBuEPOn6Yo2W2",
                        "text" : "bien he dormido bastante bien🫣",
                        "timestamp": Timestamp(date: Date())
                    ]
                )
            )
        }
        .background(Constants.fondoChat)
    }

}
