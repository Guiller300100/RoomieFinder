//
//  PerfilDetailView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 4/4/24.
//

import SwiftUI

struct PerfilDetailView: View {

    let usuario: Usuario

    var body: some View {
        ZStack {
            Constants.secondaryColor.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {

                    Image("Perfil")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 243, height: 194)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()

                    VStack(alignment: .leading) {
                        Text("\(String(describing: usuario.nombre)), años")
                            .customFont(font: .mediumFont, size: 24)
                            .padding(.leading)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("¿Qué estudio?")
                            .customFont(font: .mediumFont, size: 24)
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack { // Tabular el texto "Me gusta" una posición a la izquierda
                            Spacer()
                            Text("• ")
                                .customFont(font: .regularFont, size: 18)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.leading)

                        Text("Me gusta")
                            .customFont(font: .mediumFont, size: 24)
                            .padding(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)


                        HStack { // Tabular el texto "Me gusta" una posición a la izquierda
                            Spacer()
                            Text("• ver series, ir al gym, salir de fiesta de vez en cuando, viajar, leer y pintar")
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
                            Text("• Soy Lydia, desde siempre he sido una chica muy tranquila a la que le encanta ponerse en modo chill y poder disfrutar de series o libros. A la hora de buscar piso prefiero gente que también sea tranquila pero de vez en cuando salga de fiesta o haga planes divertidos (excursiones, visitas..) Por lo general suelo volver muchos fines a León, por lo que no Soy Lydia, desde siempre he sido una chica muy tranquila a la que le encanta ponerse en modo chill y poder disfrutar de series o libros. A la hora de buscar piso prefiero gente que también sea tranquila pero de vez en cuando salga de fiesta o haga planes divertidos (excursiones, visitas..) Por lo general suelo volver muchos fines a León, por lo que no")
                                .customFont(font: .regularFont, size: 18)
                                .lineLimit(nil)
                                .padding(.horizontal)
                        }
                        .padding(.leading)

                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    PerfilDetailView(usuario: Usuario(id: "", userID: "", nombre: "", apellido: "", fnac: "", info: Info(estudios: "", universidad: "", idiomas: Set<Idiomas>(), sexo: "", tipoPersona: "", ambiente: "", tiempoLibre: "", fumar: false, fiesta: false, descripcion: "", urlImage: "")))
}
