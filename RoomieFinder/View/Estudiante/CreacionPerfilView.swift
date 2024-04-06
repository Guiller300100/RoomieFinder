//
//  CreacionPerfilView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 6/4/24.
//

import SwiftUI

struct CreacionPerfilView: View {

    @StateObject private var creacionViewModel = CreacionPerfilViewModel()

    var body: some View {
        VStack {
            TopBarView()
            ScrollView {
                Text("Creación de perfil")
                    .customFont(.mediumFont, size: 24)
                    .foregroundStyle(Constants.mainColor)
                    .padding(.all, 15)

                Spacer()
            }

        }
        .sheet(isPresented: $creacionViewModel.isShowingPhotoPicker, content: {
                    PhotoPicker.init(avatarImage: $creacionViewModel.avatarImage)
                })
    }
}

#Preview {
    CreacionPerfilView()
}
