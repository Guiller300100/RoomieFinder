//
//  PerfilRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 27/4/24.
//

import Foundation
import SwiftUI

struct PerfilRow: View {

    //Array de datos
    @StateObject var globalViewModel = GlobalViewModel.shared

    @State private var isFavorited: Bool = false
    let anuncio: Anuncio
    @State var usuario: Usuario?

    init(anuncio: Anuncio) {
        self.anuncio = anuncio


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
                    Text("\(usuario?.nombre ?? ""), \(calcularEdad(from: usuario?.fnac ?? "")) años")
                        .customFont(font: .mediumFont, size: 14)
                        .lineLimit(nil)
                    Text("• Presupuesto: \(eliminarUltimoEuro(anuncio.presupuesto))€")
                        .customFont(font: .regularFont, size: 12)
                        .padding(.top, 0.5)
                    Text("• Zona \(eliminarZonaOBarrio(from: anuncio.barrio))")
                        .customFont(font: .regularFont, size: 12)
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

            if !anuncio.num_hab.isEmpty {
                HStack {
                    Spacer()

                    Image(systemName: "house")
                        .foregroundStyle(.black)
                        .frame(width: 20, height: 18)
                }
                .padding(.horizontal, 11)
            }
            Spacer()
        }
        .padding(.horizontal, 7)
        .frame(width: 160, height: 190)
        .background(Color.second)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .onAppear {
            usuario = globalViewModel.users.first(where: { $0.userID == anuncio.userID })!
            //edad = calcularEdad(from: usuario.fnac)
            //isFavorited = perfil.favorito
        }

    }
}

private func eliminarUltimoEuro(_ cadena: String) -> String {
    // Verificar si el último carácter es €
    if cadena.hasSuffix("€") {
        // Si es así, eliminar el último carácter
        return String(cadena.dropLast())
    }
    // Si no es €, devolver la cadena original
    return cadena
}

private func eliminarZonaOBarrio(from cadena: String) -> String {
    var resultado = cadena
    let palabrasAEliminar = ["zona", "barrio"]

    for palabra in palabrasAEliminar {
        if resultado.lowercased().contains(palabra) {
            resultado = resultado.replacingOccurrences(of: palabra, with: "", options: .caseInsensitive, range: nil)
        }
    }

    // Eliminar espacios en blanco al principio y al final, y reducir múltiples espacios a uno
    resultado = resultado.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)

    return resultado
}


private func calcularEdad(from fechaNacimientoString: String, with format: String = "yyyy-MM-dd") -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format

    guard let fechaNacimiento = dateFormatter.date(from: fechaNacimientoString) else {
        return 0
    }

    let calendar = Calendar.current
    let now = Date()
    let ageComponents = calendar.dateComponents([.year], from: fechaNacimiento, to: now)
    return ageComponents.year!
}
