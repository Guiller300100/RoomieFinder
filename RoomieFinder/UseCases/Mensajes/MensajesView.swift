//
//  MensajesView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct MensajesView: View {
    @StateObject var viewModel: MensajesViewModel
    
    init(_ viewModel: MensajesViewModel) {
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
                        HStack {
                            
                            Spacer()
                            Text("Mensajes")
                                .customFont(.mediumFont, size: 24)
                                .offset(x: 40)
                                .foregroundStyle(Constants.mainColor)
                            
                            Spacer()
                            
                            if viewModel.isToggleOn {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .trailing)
                                    .foregroundStyle(.yellow)
                            } else {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .trailing)
                                    .foregroundStyle(.gray)
                            }
                            
                            Toggle(isOn: $viewModel.isToggleOn){
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Constants.mainColor))
                            .labelsHidden()
                        }
                        .padding(.all, 15)
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
    MensajesView(MensajesViewModel())
}
