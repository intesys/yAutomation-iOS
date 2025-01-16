//
//  PickersView.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//

import SwiftUI

enum PickersId : String {
    case picker, wheelPicker
}
struct PickersView: View {
    
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"

    var body: some View {
        Form {
            Section {
                Picker("Please choose a color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }.accessibilityIdentifier(PickersId.picker.rawValue)
            }
            
            Section {
                Picker("Please choose a color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.wheel)
                    .accessibilityIdentifier(PickersId.wheelPicker.rawValue)
            }
            
            Section {
                Text("You selected: \(selectedColor)")
            }

        }.navigationTitle("👇 Pickers")
    }
}

#Preview {
    PickersView()
}
