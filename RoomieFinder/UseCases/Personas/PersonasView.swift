//
//  PersonasView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct PersonasView: View {
    @StateObject var viewModel: PersonasViewModel
    @State private var isShowed: Bool = false
    @State private var perfilSeleccionado: Perfil?
    
    init(_ viewModel: PersonasViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            TopBarView()
            ScrollView {
                VStack {
                    Text("Inicio")
                        .customFont(.mediumFont, size: 24)
                        .foregroundStyle(Constants.mainColor)
                        .padding(.top, 15)
                    
                    
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(viewModel.perfilList) { perfil in
                            PerfilRow(perfil: perfil)
                                .onTapGesture {
                                    // Delay the state updates to allow data retrieval
                                    DispatchQueue.main.async {
                                        self.perfilSeleccionado = perfil
                                        self.isShowed = true
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                    
                }
            }
        }
        
        
        //MARK: - VISTA MODAL PERSONAS
        .sheet(isPresented: $isShowed) {
            if let perfil = perfilSeleccionado {
                PerfilDetailView(perfil: perfil)
                    .presentationDetents([.fraction(0.80)])
            }
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }
    
    
}

struct PerfilRow: View {
    
    @State private var isFavorited: Bool
    var perfil : Perfil
    
    init(perfil: Perfil) {
        self.perfil = perfil
        self._isFavorited = State(initialValue: perfil.favorito)
    }
    
    var body: some View {
        VStack {
            Image("Perfil")
                .resizable()
                .frame(width: 91, height: 71)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 13)
            
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(perfil.nombre ?? ""), \(perfil.edad ?? 0) años")
                        .customFont(.mediumFont, size: 14)
                        .lineLimit(nil)
                    Text("- Presupuesto: \(perfil.presupuesto ?? 0)€")
                        .customFont(.regularFont, size: 12)
                        .padding(.top, 0.5)
                    Text("- Zona \(perfil.barrio ?? "")")
                        .customFont(.regularFont, size: 12)
                    Spacer()
                }
                
                
                VStack {
                    Button(action: {
                        isFavorited.toggle()
                    }, label: {
                        if isFavorited {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .frame(width: 20, height: 18)
                        } else {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.gray)
                                .frame(width: 20, height: 18)
                        }
                    })
                    Spacer()
                }
            }
            
            Spacer()
        }
        .frame(width: 160, height: 190)
        .background(Color.second)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .onAppear {
            isFavorited = perfil.favorito
        }
        
    }
}

#Preview {
    PersonasView(PersonasViewModel())
}
