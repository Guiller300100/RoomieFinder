//
//  MultiPickerView.swift
//  RoomieFinder
//
//  Created by Guillermo Rodriguez Alonso on 6/4/24.
//

import SwiftUI

struct MultiPicker: View {
    @Binding var selectedItems: Set<Idiomas> // Variable para almacenar las opciones seleccionadas
    let options: [Idiomas] // Lista de opciones disponibles

    var body: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    // Agregar o eliminar la opción de la selección
                    if selectedItems.contains(option) {
                        selectedItems.remove(option)
                    } else {
                        selectedItems.insert(option)
                    }
                }) {
                    HStack {
                        Text(option.rawValue)
                            .customFont(font: .regularFont, size: 18, color: .black)
                        Spacer()
                        Image(systemName: selectedItems.contains(option) ? "checkmark.circle.fill" : "circle")
                    }

                }
            }
        }
    }
}
