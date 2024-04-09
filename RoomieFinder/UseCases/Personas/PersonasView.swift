//
//  PersonasView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct PersonasView: View {
    @StateObject var viewModel: PersonasViewModel
    var perfilList: [Perfil]?
    @State private var isShowed: Bool = false
    @State private var perfilSeleccionado: Perfil?

    init(_ viewModel: PersonasViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }


      // Mantener el inicializador original como opcional.
      init(_ viewModel: PersonasViewModel, _ perfilList: [Perfil]) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.perfilList = perfilList
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
                        Text("Inicio")
                            .customFont(.mediumFont, size: 24)
                            .foregroundStyle(Constants.mainColor)
                            .padding(.top, 15)

                        if let PerfilListDes = perfilList {
                            LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                                ForEach(PerfilListDes) { perfil in
                                    PerfilRow(perfil: perfil)
                                        .onTapGesture {
                                            self.perfilSeleccionado = perfil
                                            isShowed = true
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }


            //MARK: - VISTA MODAL PERSONAS
            .sheet(isPresented: $isShowed) {
                if let perfil = perfilSeleccionado {

                    PerfilDetailView(perfil: perfil)
                        .presentationDetents([.fraction(0.75)])
                }
            }
            .onAppear {
                self.viewModel.onAppear()
            }
            .loaderBase(state: self.viewModel.state)
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
