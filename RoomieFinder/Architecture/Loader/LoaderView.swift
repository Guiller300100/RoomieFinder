//
//  LoaderView.swift
//  MyEdex
//
//  Created by Raul Pascual de la Calle on 8/4/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack(alignment: .center, spacing: 0.0) {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(2.0)
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoaderView()
}

extension View {
    func loaderBase(state: ViewModelState) -> some View {
        self.modifier(LoaderModifier(state: state, loader: AnyView(LoaderView())))
    }
}

struct LoaderModifier: ViewModifier {
    var state: ViewModelState
    var loader: AnyView
    
    func body(content: Content) -> some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            content
            if state == ViewModelState.loading {
                loader
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        })
    }
}
