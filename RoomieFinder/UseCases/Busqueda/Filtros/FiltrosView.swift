//
//  FiltrosView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 28/4/24.
//

import SwiftUI

struct FiltrosView: View {

    @State var hombreCheck = false
    @State var mujerCheck = false
    @State var fumadorCheck = false
    @State var noFumadorCheck = false
    @State var fiestaCheck = false
    @State var noFiestaCheck = false
    @State var estudianteCheck = false
    @State var grupoCheck = false

    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Sexo:")
                        .customFont(font: .boldFont, size: 14)
                        .padding(.bottom, 5)

                    sexoFiltro

                    Text("Fumador:")
                        .customFont(font: .boldFont, size: 14)
                        .padding(.bottom, 5)

                    fumadorFiltro

                    Text("Fiesta:")
                        .customFont(font: .boldFont, size: 14)
                        .padding(.bottom, 5)

                    fiestaFiltro

                    Text("Estudiantes/grupos:")
                        .customFont(font: .boldFont, size: 14)
                        .padding(.bottom, 5)

                    tipoFiltro

                    //PROBLEMA CON LOS GRUPOS
                    Text("Ambiente en casa:")
                        .customFont(font: .boldFont, size: 14)
                        .padding(.bottom, 5)

                    ambienteFiltro

                    Text("Idiomas:")
                        .customFont(font: .boldFont, size: 14)
                        .padding(.bottom, 5)

                    idiomasFiltro

                }
                //TODO: Cuando se de al boton de ver resultados, comprobar si fumar esta seleccionado ambos, ya que es incongruencia, lo mismo con Fiesta o si tiene ambos mostrar ambas opciones


            }
            .padding()


            HStack {
                Button(action: {
                    //
                }) {
                    Text("Limpiar filtros")
                        .customFont(font: .boldFont, size: 14, color: .black)
                        .frame(width: 128, height: 36)
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .stroke(.black, lineWidth: 2)

                        )


                }

                Spacer()

                Button(action: {
                    //
                }) {
                    Text("Ver resultados")
                        .customFont(font: .boldFont, size: 14)
                        .frame(width: 129, height: 36)
                        .foregroundStyle(.white)
                        .background(Constants.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Filtros")
    }

    private var sexoFiltro: some View {

        HStack {
            Button {
                hombreCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: hombreCheck ? "checkmark.circle.fill" : "circle")

                    Text("Hombre")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                mujerCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: mujerCheck ? "checkmark.circle.fill" : "circle")

                    Text("Mujer")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 26)
    }

    private var fumadorFiltro: some View {

        HStack {
            Button {
                fumadorCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: fumadorCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                noFumadorCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: noFumadorCheck ? "checkmark.circle.fill" : "circle")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 26)
    }

    private var fiestaFiltro: some View {

        HStack {
            Button {
                fiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: fiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                noFiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 26)
    }

    private var tipoFiltro: some View {

        HStack {
            Button {
                fiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: fiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Estudiantes")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                noFiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Grupos")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 26)
    }

    private var ambienteFiltro: some View {

        HStack {
            Button {
                fiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: fiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Activo")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                noFiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Tranquilo")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                noFiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("50/50")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 26)
    }

    private var idiomasFiltro: some View {

        VStack(alignment: .leading) {
            //MARK: PRIMERA FILA IDIOMAS
            HStack {
                Button {
                    fiestaCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: fiestaCheck ? "checkmark.circle.fill" : "circle")

                        Text("Español")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }
                .padding(.leading, 10)

                Spacer()

                Button {
                    noFiestaCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                        Text("Inglés")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }

                Spacer()

                Button {
                    noFiestaCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                        Text("Francés")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }
                .padding(.trailing, 10)
            }
            .padding(.bottom, 10)

            //MARK: SEGUNDA FILA IDIOMAS
            HStack {
                Button {
                    noFiestaCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                        Text("Portugués")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }
                .padding(.leading, 10)

                Spacer()

                Button {
                    noFiestaCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                        Text("Alemán")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }

                Spacer()

                Button {
                    noFiestaCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: noFiestaCheck ? "checkmark.circle.fill" : "circle")

                        Text("Italiano")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }
                .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 26)
    }
}

#Preview {
    FiltrosView()
}
