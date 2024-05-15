//
//  AnunciosActivosView.swift
//
//  Created on 20/4/24
//

import SwiftUI

struct AnunciosActivosView: View {
    @StateObject var viewModel: AnunciosActivosViewModel

    init(_ viewModel: AnunciosActivosViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        VStack {
            TopBarView()

            ScrollView {

                HStack{
                    VistaAnteriorButton()
                    Spacer()
                }
                .padding(.init(top: 13, leading: 15, bottom: 0, trailing: 15))
                .frame(maxWidth: .infinity)

                textLabel

                AnuncioRow()

                AnuncioRow()

                buttonNewLabel

            }
        }

        .navigationDestination(isPresented: $viewModel.isNavigated) {
            CreacionAnuncioView(CreacionAnuncioViewModel(firstTime: false))
                .navigationBarBackButtonHidden()
        }
    }

    private var textLabel: some View {
        Text("Anuncios activos")
            .customFont(font: .mediumFont, size: 24)
            .foregroundStyle(Constants.mainColor)
            .padding(.top, 26)

    }

    private var buttonNewLabel: some View {
        Button(action: {
            viewModel.isNavigated = true

        }) {
            Text("Nuevo anuncio")
                .customFont(font: .boldFont, size: 15)
                .frame(width: 131, height: 40)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))
        }
    }

}



private struct VistaAnteriorButton: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 30))
            }
        }
    }
}

#Preview {
    AnunciosActivosView(AnunciosActivosViewModel())
}
