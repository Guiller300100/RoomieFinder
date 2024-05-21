//
//  PerfilRow.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 27/4/24.
//

import Foundation
import SwiftUI
import FirebaseStorage

struct PerfilRow: View {

    //Array de datos
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    @State private var avatarImage: UIImage? = nil
    let anuncio: Anuncio
    @State var usuario: Usuario?

    init(anuncio: Anuncio) {
        self.anuncio = anuncio

    }

    var body: some View {
        VStack {
            Image(uiImage: (avatarImage ?? UIImage(named: "DefaultAvatarImage")!))
                .resizable()
                .frame(width: 81, height: 71)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 13)



            HStack {
                VStack(alignment: .leading) {
                    Text("\(usuario?.nombre ?? ""), \(calcularEdad(from: usuario?.fnac ?? "")) años")
                        .customFont(font: .mediumFont, size: 14)
                        .lineLimit(nil)
                    Text((anuncio.num_hab.isEmpty ? "• Presupuesto:" : "• Precio:") + "\(eliminarUltimoEuro(anuncio.presupuesto))€")
                        .customFont(font: .regularFont, size: 12)
                        .padding(.top, 0.5)
                    Text("• Zona \(eliminarZonaOBarrio(from: anuncio.barrio))")
                        .customFont(font: .regularFont, size: 12)
                    Spacer()
                }


                VStack {
                    //TODO: TENGO QUE MIRAR LO DE FAV
                    Button(action: {
                        if isUserInFavorites(userID: usuario?.userID ?? ""){
                            globalViewModel.deleteFav()
                        } else {
                            globalViewModel.updateFav(userFavID: usuario?.userID ?? "")
                        }
                    }, label: {
                        Image(systemName: isUserInFavorites(userID: usuario?.userID ?? "") ? "star.fill" : "star")
                            .foregroundColor(.yellow)

                    })
                    Spacer()
                }
            }

            if !anuncio.num_hab.isEmpty {
                HStack {
                    Text("Nº habs: \(anuncio.num_hab)")
                        .customFont(font: .regularFont, size: 12)

                    Spacer()
                    
                    Image(systemName: "house")
                        .resizable()
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
                    updateUsuario()
                    loadImage()
                }
                .onChange(of: globalViewModel.users) { _ in
                    updateUsuario()
                    loadImage()
                }
            }

            private func updateUsuario() {
                usuario = globalViewModel.users.first { $0.userID == anuncio.userID }
            }

            private func loadImage() {
                guard let imageUrl = usuario?.info.urlImage else { return }
                getPhoto(url: imageUrl) { image in
                    avatarImage = image
                }
            }

            private func isUserInFavorites(userID: String) -> Bool {
                return globalViewModel.favoritos.contains { $0.favUserID == userID }
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


private func getPhoto(url: String, completion: @escaping (UIImage?) -> Void) {
    let storageRef = Storage.storage().reference()
    let fileRef = storageRef.child(url)

    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
        DispatchQueue.main.async {
            if let error = error {
                print("Error getting image data: \(error)")
                completion(nil)
            } else if let data = data {
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    print("Error creating UIImage from data")
                    completion(nil)
                }
            } else {
                print("No data received")
                completion(nil)
            }
        }
    }
}
