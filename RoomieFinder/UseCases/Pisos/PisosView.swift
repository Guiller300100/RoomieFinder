//
//  PisosView.swift
//
//  Created on 9/4/24
//

import SwiftUI

struct PisosView: View {
    @StateObject var viewModel: PisosViewModel
    var anunciosPisos: [AnuncioPisos]?
    @State private var isShowed: Bool = false
    @State private var pisoSeleccionado: AnuncioPisos?

    init(_ viewModel: PisosViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
      }

      init(_ viewModel: PisosViewModel, _ anunciosPisos: [AnuncioPisos]) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.anunciosPisos = anunciosPisos
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
                HStack {
                    Button(action: {

                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Constants.mainColor)
                    }

                    Spacer()

                    Text("Pisos")
                        .customFont(.mediumFont, size: 24)
                        .offset(x: 20)
                        .foregroundStyle(Constants.mainColor)

                    Spacer()

                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Constants.mainColor)

                    Divider()
                        .overlay(Rectangle().foregroundStyle(Constants.mainColor))

                    Image(systemName: "map.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Constants.mainColor)

                }
                .frame(height: 25)
                .padding(.all, 15)


                ScrollView {
                    if let Anuncios_PisosDes = anunciosPisos {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], spacing: 16) {
                            ForEach(Anuncios_PisosDes) { piso in
                                PisoRow(piso: piso)
                                    .onTapGesture {
                                        pisoSeleccionado = piso
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }

                }
                .frame(maxHeight: .infinity)
            }
            .onAppear {
                self.viewModel.onAppear()
            }
            .loaderBase(state: self.viewModel.state)
        }

    }
}

struct PisoRow: View {

    @State private var isFavorited: Bool
    var piso : AnuncioPisos

    init(piso: AnuncioPisos) {
        self.piso = piso
        self._isFavorited = State(initialValue: false)
    }

    var body: some View {
        HStack(spacing: 15) {
            Image("Piso")
                .resizable()
                .frame(width: 135, height: 111)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 1) {
                Text("\(piso.precio ?? 0)€")
                    .customFont(.mediumFont, size: 14)
                    .lineLimit(nil)

                Text("- \(piso.numHabitaciones ?? 0) habitaciones")
                    .customFont(.regularFont, size: 12)


                Text("- \(piso.numBaños ?? 0) baños")
                    .customFont(.regularFont, size: 12)

                Text("- \(removeCity(from: piso.dirección) ?? "")")
                    .customFont(.regularFont, size: 12)
                    .lineLimit(nil)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)

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
        .padding()
        .frame(width: 350, height: 133)
        .background(Color.second) // Cambiamos el color de fondo para visualizar mejor
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .onAppear {
            isFavorited = false
        }
    }
}


func removeCity(from address: String?) -> String? {
    guard let address = address else { return nil }

    let components = address.components(separatedBy: ",")
    if components.count > 1 {
        return components.dropLast().joined(separator: ",")
    } else {
        return address
    }
}


#Preview {
    PisosView(PisosViewModel())
}
