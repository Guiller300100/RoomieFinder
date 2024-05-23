//
//  FiltrosView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 28/4/24.
//

import SwiftUI

struct FiltrosView: View {

    //ARRAYS DE DATOS
    @ObservedObject var globalViewModel = GlobalViewModel.shared
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {

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

                Text("Estudiantes/trabajadores:")
                    .customFont(font: .boldFont, size: 14)
                    .padding(.bottom, 5)

                tipoFiltro

                Text("Ambiente en casa:")
                    .customFont(font: .boldFont, size: 14)
                    .padding(.bottom, 5)

                ambienteFiltro

                Text("Idiomas:")
                    .customFont(font: .boldFont, size: 14)
                    .padding(.bottom, 5)

                idiomasFiltro

                Text("¿Tiene casa?")
                    .customFont(font: .boldFont, size: 14)
                    .padding(.bottom, 5)

                casaFiltro

                // MARK: Add presupuesto filter with slider
                Text("Presupuesto máximo:")
                    .customFont(font: .boldFont, size: 14)
                    .padding(.bottom, 5)

                presupuestoFiltro

            }
            .padding(.horizontal, 16)

            HStack {
                Image(systemName: "info.circle")
                    .foregroundStyle(.accent)

                Text("No selecciones ninguna opción dentro de la misma categoria, para que salgan ambos casos.")
                    .customFont(font: .regularFont, size: 14)
                    .foregroundStyle(.accent)
            }
            .padding(.all, 7)

            HStack {
                limpiarButton

                Spacer()

                resultadosButton

            }
            .padding(.horizontal, 40)

            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Filtros")

        .alert(isPresented: $globalViewModel.alertPush, content: {
            Alert(title: Text(globalViewModel.alertTitle), message: Text(globalViewModel.alertMessage), dismissButton: .default(Text("Vale")))
        })
    }

    private var sexoFiltro: some View {

        HStack {
            Button {
                globalViewModel.hombreCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.hombreCheck ? "checkmark.circle.fill" : "circle")

                    Text("Hombre")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                globalViewModel.mujerCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.mujerCheck ? "checkmark.circle.fill" : "circle")

                    Text("Mujer")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 15)
    }

    private var fumadorFiltro: some View {

        HStack {
            Button {
                globalViewModel.fumadorCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.fumadorCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                globalViewModel.noFumadorCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.noFumadorCheck ? "checkmark.circle.fill" : "circle")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 15)
    }

    private var fiestaFiltro: some View {

        HStack {
            Button {
                globalViewModel.fiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.fiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Si")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                globalViewModel.noFiestaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.noFiestaCheck ? "checkmark.circle.fill" : "circle")

                    Text("No")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 15)
    }

    private var tipoFiltro: some View {

        HStack {
            Button {
                globalViewModel.estudianteCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.estudianteCheck ? "checkmark.circle.fill" : "circle")

                    Text("Estudiantes")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                globalViewModel.trabajadorCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.trabajadorCheck ? "checkmark.circle.fill" : "circle")

                    Text("Trabajadores")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 15)
    }

    private var ambienteFiltro: some View {

        HStack {
            Button {
                globalViewModel.activoCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.activoCheck ? "checkmark.circle.fill" : "circle")

                    Text("Activo")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                globalViewModel.tranquiloCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.tranquiloCheck ? "checkmark.circle.fill" : "circle")

                    Text("Tranquilo")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }

            Button {
                globalViewModel.ambosCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.ambosCheck ? "checkmark.circle.fill" : "circle")

                    Text("50/50")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 15)
    }

    private var idiomasFiltro: some View {

        VStack(alignment: .leading) {
            //MARK: PRIMERA FILA IDIOMAS
            HStack {
                Button {
                    globalViewModel.españolCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: globalViewModel.españolCheck ? "checkmark.circle.fill" : "circle")

                        Text("Español")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }
                .padding(.leading, 10)

                Spacer()

                Button {
                    globalViewModel.inglesCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: globalViewModel.inglesCheck ? "checkmark.circle.fill" : "circle")

                        Text("Inglés")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }

                Spacer()

                Button {
                    globalViewModel.francesCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: globalViewModel.francesCheck ? "checkmark.circle.fill" : "circle")

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
                    globalViewModel.portuguesCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: globalViewModel.portuguesCheck ? "checkmark.circle.fill" : "circle")

                        Text("Portugués")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }
                .padding(.leading, 10)

                Spacer()

                Button {
                    globalViewModel.alemanCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: globalViewModel.alemanCheck ? "checkmark.circle.fill" : "circle")

                        Text("Alemán")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }

                Spacer()

                Button {
                    globalViewModel.italianoCheck.toggle()

                } label: {
                    HStack {
                        Image(systemName: globalViewModel.italianoCheck ? "checkmark.circle.fill" : "circle")

                        Text("Italiano")
                            .customFont(font: .regularFont, size: 14)
                            .foregroundStyle(.black)
                    }

                }
                .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 15)
    }

    private var casaFiltro: some View {

        HStack {
            Button {
                globalViewModel.casaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName: globalViewModel.casaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Con casa")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 10)

            Button {
                globalViewModel.noCasaCheck.toggle()

            } label: {
                HStack {
                    Image(systemName:
                            globalViewModel.noCasaCheck ? "checkmark.circle.fill" : "circle")

                    Text("Sin casa")
                        .customFont(font: .regularFont, size: 14)
                        .foregroundStyle(.black)
                }

            }
        }
        .padding(.bottom, 15)
    }

    private var presupuestoFiltro: some View {
        HStack {
            Slider(value: $globalViewModel.presupuestoMaximo, in: 0...1000, step: 100)

            Text("\(globalViewModel.presupuestoMaximo < 1 ? "-" : String(globalViewModel.presupuestoMaximo.toInt() ?? 0)) €")
        }
        .padding(.bottom, 15)
    }

    private var limpiarButton: some View {
        HStack {
            Button(action: {
                limpiarFiltros(globalViewModel: globalViewModel)
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

        }
    }

    private var resultadosButton: some View {
        Button(action: {
            globalViewModel.comprobarCheck()
            if globalViewModel.correctChecks {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Ver resultados")
                .customFont(font: .boldFont, size: 14)
                .frame(width: 129, height: 36)
                .foregroundStyle(.white)
                .background(Constants.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

}

private func limpiarFiltros(globalViewModel: GlobalViewModel) {
    globalViewModel.hombreCheck = false
    globalViewModel.mujerCheck = false
    globalViewModel.fumadorCheck = false
    globalViewModel.noFumadorCheck = false
    globalViewModel.fiestaCheck = false
    globalViewModel.noFiestaCheck = false
    globalViewModel.estudianteCheck = false
    globalViewModel.trabajadorCheck = false
    globalViewModel.activoCheck = false
    globalViewModel.tranquiloCheck = false
    globalViewModel.ambosCheck = false
    globalViewModel.españolCheck = false
    globalViewModel.inglesCheck = false
    globalViewModel.francesCheck = false
    globalViewModel.portuguesCheck = false
    globalViewModel.alemanCheck = false
    globalViewModel.italianoCheck = false
    globalViewModel.casaCheck = false
    globalViewModel.noCasaCheck = false
    globalViewModel.presupuestoMaximo = 0

}

#Preview {
    FiltrosView()
}
