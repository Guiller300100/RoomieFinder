//
//  BusquedaView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct BusquedaView: View {
    @StateObject var viewModel: BusquedaViewModel
    
    init(_ viewModel: BusquedaViewModel) {
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
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Constants.mainColor)
                            Spacer()
                            Text("Búsqueda")
                                .customFont(.mediumFont, size: 24)
                                .offset(x: -13)
                                .foregroundStyle(Constants.mainColor)
                            
                            Spacer()
                        }
                        .frame(height: 25)
                        .padding(.all, 15)
                        
                        
                        Text("Prueba")
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
    BusquedaView(BusquedaViewModel())
}
