//
//  PerfilView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct PerfilView: View {
    @StateObject var viewModel: PerfilViewModel

    init(_ viewModel: PerfilViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()
            VStack {

                textLabel

                imageLabel

                buttonsLabel

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()

        }

        .navigationDestination(isPresented: $viewModel.navigationCheck,
                               destination: {
            withAnimation {
                AnunciosActivosView(
                    AnunciosActivosViewModel()
                )
                .navigationBarBackButtonHidden(true)
            }
        })

        .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
            PhotoPicker.init(avatarImage: $viewModel.avatarImage)
        })
    }

    private var textLabel: some View {
        Text("Mi perfil")
            .customFont(.mediumFont, size: 24)
            .foregroundStyle(Constants.mainColor)
            .padding(.top, 15)
    }

    private var imageLabel: some View {
        VStack{
            Image(uiImage: viewModel.avatarImage)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .overlay(
                    Circle()
                        .stroke(Constants.mainColor, lineWidth: 3)
                )
                .onTapGesture {
                    viewModel.isShowingPhotoPicker = true
                }

            Button(action: {
                viewModel.isShowingPhotoPicker = true
            }, label: {
                Text("Editar Avatar")
                    .customFont(.mediumFont, size: 13)
                    .foregroundStyle(Color("AccentColor"))
            })
        }
    }

    private var buttonsLabel: some View {
        VStack {
            Spacer()

            //MARK: BOTON EDITAR
            Button(action: {

            }) {
                Text("Editar información personal")
                    .customFont(.boldFont, size: 15)
                    .frame(width: 217, height: 41)
                    .foregroundStyle(.white)
                    .background(Constants.mainColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }


            Spacer()

            //MARK: BOTON ANUNCIOS
            Button(action: {
                viewModel.navigationCheck = true
            }) {
                Text("Anuncios activos")
                    .customFont(.boldFont, size: 15)
                    .frame(width: 144, height: 41)
                    .foregroundStyle(.white)
                    .background(Constants.mainColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            Spacer()
        }

    }

}


#Preview {
    PerfilView(PerfilViewModel())
}
