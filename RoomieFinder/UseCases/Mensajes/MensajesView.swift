//
//  MensajesView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct MensajesView: View {
    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    @StateObject var viewModel: MensajesViewModel
    

    init(_ viewModel: MensajesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
            
            VStack {
                TopBarView()
                
                headerLabel
                
                messageView
            }
            .onAppear() {
                viewModel.onAppear()
            }
            .navigationDestination(isPresented: $viewModel.chatNavigation, destination: {
                if let recentMessage = viewModel.chatSeleccionado {
                    if let toUser = globalViewModel.users.first(where: { $0.userID == recentMessage.toId }) {
                        withAnimation {
                            ChatLogView(toUser: toUser)
                        }
                    } else {
                        if let toUser = globalViewModel.users.first(where: { $0.userID == recentMessage.fromId }) {
                            withAnimation {
                                ChatLogView(toUser: toUser)
                            }
                        }
                    }



                }
            })
    }

    private var headerLabel: some View {
        HStack {

            Spacer()
            Text("Mensajes")
                .customFont(font: .mediumFont, size: 24)
                .foregroundStyle(Constants.mainColor)

            Spacer()
        }
        .padding(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
    }

    private var messageView: some View {
        ScrollView {


            ForEach(viewModel.recentMessages) { recentMessage in

                VStack {
                    ChatRow(recentMessage: recentMessage)
                        .onTapGesture {
                            DispatchQueue.main.async {
                                self.viewModel.chatSeleccionado = recentMessage
                                self.viewModel.chatNavigation = true
                            }
                        }

                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.init(top: 1, leading: 5, bottom: 0, trailing: 5))
            }
        }
    }
}

struct MensajesView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            MensajesView(MensajesViewModel())
        }
    }

}
