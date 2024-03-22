//
//  PisoRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 22/3/24.
//

import SwiftUI

struct PisoRow: View {
    
    @State private var isFavorited: Bool
    var piso : AnuncioPisosModel
    
    init(piso: AnuncioPisosModel) {
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
                    .font(.custom(Constants.mediumFont, size: 14))
                    .lineLimit(nil)
                
                Text("- \(piso.numHabitaciones ?? 0) habitaciones")
                    .font(.custom(Constants.regularFont, size: 12))
                
                Text("- \(piso.numBaños ?? 0) baños")
                    .font(.custom(Constants.regularFont, size: 12))
                
                Text("- \(removeCity(from: piso.dirección) ?? "")")
                    .font(.custom(Constants.regularFont, size: 12))
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



struct PisoCell_Previews: PreviewProvider {
    static var previews: some View {
        PisoRow(piso: AnuncioPisosModel(idAnuncio: 1, dirección: "Calle Ciudad de la Habana, 3, Valladolid", numHabitaciones: 2, numBaños: 2, precio: 1000, descripción: "Grande"))
            .previewLayout(.sizeThatFits)
    }
}
