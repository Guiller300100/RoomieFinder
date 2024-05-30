//
//  ChatLogView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 23/5/24.
//

import SwiftUI

struct ChatLogView: View {

    //Array de datos
    @ObservedObject var globalViewModel = GlobalViewModel.shared
    @ObservedObject var viewModel: ChatLogViewModel

    let emptyScrollToString = "Empty"
    let toUser: Usuario

    init(
        toUser: Usuario
    ) {
        self.toUser = toUser
        self.viewModel = .init(toUser: toUser)
    }

    // MARK: BODY
    var body: some View {
        ZStack {
            messagesView
            Text(viewModel.errorMessage)
        }
        .navigationTitle("\(toUser.nombre) \(toUser.apellido)")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: messageView
    private var messagesView: some View {
        VStack {
            ScrollView {
                ScrollViewReader { ScrollViewProxy in
                    VStack {
                        ForEach(viewModel.chatMessages) { message in
                            MessageBubble(message: message)
                        }

                        HStack {
                            Spacer()
                        }
                        .id(emptyScrollToString)
                    }
                    .onReceive(viewModel.$count) { _ in
                        withAnimation(.easeOut(duration: 0.3)) {
                            ScrollViewProxy.scrollTo(emptyScrollToString, anchor: .bottom)
                        }
                    }
                    .onChange(of: viewModel.message) { _ in
                        if viewModel.message.count == 1 {
                            withAnimation(.easeOut(duration: 0.3)) {
                                ScrollViewProxy.scrollTo(emptyScrollToString, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            chatBottomBar
                .background(.white)


        }
        .background(Constants.fondoChat)

    }


    // MARK: BottonBar
    private var chatBottomBar: some View {
        HStack {
            TextField("Mensaje", text: $viewModel.message)
                .toolbar(content: {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()

                            Button {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            } label: {
                                Text(Image(systemName: "chevron.down"))

                            }

                        }
                    }
                })
                .opacity(viewModel.message.isEmpty ? 0.5 : 1)
                .frame(height: 35)
            Button {
                viewModel.handleSend()
            } label: {
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(!viewModel.message.isEmpty ? Constants.mainColor : Constants.mainColor.opacity(0.5))
            }
            .disabled(!viewModel.message.isEmpty ? false : true)
        }
        .onTapGesture {
            viewModel.count += 1
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Mensaje")
                .foregroundColor(Color(.gray))
                .padding(.leading, 5)
                .padding(.top, 2)
            Spacer()
        }
    }
}

struct ChatLogView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            ChatLogView(
                toUser: Usuario(
                    id: "",
                    userID: "",
                    nombre: "",
                    apellido: "",
                    fnac: "",
                    info: Info(
                        estudios: "",
                        trabaja: false,
                        universidad: "",
                        idiomas: Set<Idiomas>(),
                        sexo: "",
                        tipoPersona: "",
                        ambiente: "",
                        tiempoLibre: "",
                        fumar: false,
                        fiesta: false,
                        descripcion: "",
                        urlImage: ""
                    )
                )
            )
        }
    }

}
