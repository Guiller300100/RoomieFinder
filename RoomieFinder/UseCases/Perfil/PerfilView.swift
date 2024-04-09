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

        switch viewModel.state {
        case .error, .unknownError:
            VStack {
                Text("Here your custom Error view")
            }


        case .empty:
            VStack {
                Text("Here your custom Empty View")
            }

        case .okey, .loading:
            VStack {
                TopBarView()

                ScrollView {
                    VStack {
                        Text("Perfil")
                            .customFont(.mediumFont, size: 24)
                            .foregroundStyle(Constants.mainColor)
                            .padding(.top, 15)
                    }
                }
            }
            .onAppear {
                self.viewModel.onAppear()
            }
            .loaderBase(state: self.viewModel.state)
        }

    }
}

#Preview {
    PerfilView(PerfilViewModel())
}
