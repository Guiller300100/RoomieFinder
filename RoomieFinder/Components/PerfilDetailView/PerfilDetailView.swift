//
//  PerfilDetailView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 4/4/24.
//

import SwiftUI
import FirebaseStorage

struct PerfilDetailView: View {

    @Environment(\.presentationMode) var presentationMode

    //Array de datos
    @ObservedObject var globalViewModel = GlobalViewModel.shared

    let usuario: Usuario
    let anuncio: Anuncio
    @State private var avatarImage: UIImage? = nil
    @Binding var shouldNavigation: Bool
    @Binding var isShowed: Bool

    var body: some View {
        
        ZStack {
            Constants.secondaryColor.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {

                    perfilImage

                    infoStack

                    Spacer()
                }

                HStack {

                    Spacer()

                    buttonChat

                    Spacer()

                    buttonFav

                }
                .padding(.trailing, 16)
            }


        }

        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                getPhoto(url: usuario.info.urlImage) { image in
                    avatarImage = image
                }
            }
        }
    }

    private var perfilImage: some View {
        Image(uiImage: (avatarImage ?? UIImage(named: "DefaultAvatarImage")!))
            .resizable()
            .scaledToFill()
            .frame(width: 243, height: 194)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
    }

    private var infoStack: some View {
        VStack(alignment: .leading) {
            Text("\(usuario.nombre) \(usuario.apellido), \(calcularEdad(from: usuario.fnac)) años")
                .customFont(font: .mediumFont, size: 24)
                .padding(.leading)
                .padding(.top, 20)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("¿Qué estudio?")
                .customFont(font: .mediumFont, size: 24)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Spacer()
                Text("• \(usuario.info.estudios) en la \(usuario.info.universidad)")
                    .customFont(font: .regularFont, size: 18)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)

            Text("Me gusta")
                .customFont(font: .mediumFont, size: 24)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)


            HStack {
                Spacer()
                Text("• \(usuario.info.tiempoLibre)")
                    .customFont(font: .regularFont, size: 18)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)

            Text("Idiomas que hablo")
                .customFont(font: .mediumFont, size: 24)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)


            HStack {
                Spacer()
                Text("• \(usuario.info.idiomas.asCommaSeparatedString())")
                    .customFont(font: .regularFont, size: 18)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)


            Text("Sobre mi")
                .customFont(font: .mediumFont, size: 24)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Spacer()
                Text("• \(usuario.info.descripcion)")
                    .customFont(font: .regularFont, size: 18)
                    .lineLimit(nil)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)


            HStack {
                Spacer()
                Text("• Actualmente \(usuario.info.trabaja ? "si": "no") trabajo")
                    .customFont(font: .regularFont, size: 18)
                    .lineLimit(nil)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)


            HStack {
                Spacer()
                Text("• \(usuario.info.fumar ? "Fumo en mi dia a dia" : "No fumo en mi dia a dia") \(usuario.info.fiesta ? "y me gusta bastante salir de fiesta" : " y no me gusta mucho salir de fiesta")")
                    .customFont(font: .regularFont, size: 18)
                    .lineLimit(nil)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)



        }
    }

    private var buttonChat: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
            self.shouldNavigation = true
        } label: {
            Text("Crear chat")
                .customFont(font: .boldFont, size: 15)
                .frame(width: 92, height: 36)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 999))
        }
        .offset(x: 18)
    }

    private var buttonFav: some View {
        Button(action: {
            if isUserInFavorites(anuncioID: anuncio.id){
                globalViewModel.deleteFav()
            } else {
                globalViewModel.updateFav(anuncioID: anuncio.id)
            }
        }, label: {
            Image(systemName: isUserInFavorites(anuncioID: anuncio.id) ? "star.fill" : "star")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.yellow)
        })
    }

    private func isUserInFavorites(anuncioID: String) -> Bool {
        return globalViewModel.favoritos.contains { $0.anuncioID == anuncioID }
    }
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


struct PerfilDetailView_Previews: PreviewProvider {

    static var previews: some View {
        PerfilDetailView(
            usuario: Usuario(
                id: "",
                userID: "",
                nombre: "",
                apellido: "",
                fnac: "",
                info: Info(
                    estudios: "",
                    trabaja: false,
                    universidad: "",
                    idiomas: Set<Idiomas>(),
                    sexo: "",
                    tipoPersona: "",
                    ambiente: "",
                    tiempoLibre: "",
                    fumar: false,
                    fiesta: false,
                    descripcion: "",
                    urlImage: ""
                )
            ),
            anuncio: Anuncio(
                id: "",
                userID: "",
                barrio: "",
                tiempoEstancia: "",
                presupuesto: "",
                num_hab: ""
            ),
            shouldNavigation: .constant(false),
            isShowed: .constant(false)
        )
    }
}
