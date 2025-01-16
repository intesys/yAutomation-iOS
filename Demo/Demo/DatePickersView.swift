//
//  DatePickersView.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//

import SwiftUI

enum DatePickersId : String {
    case  datePicker, dateWheelPicker
}

struct DatePickersView: View {
    
    @State private var birthDate = Date.now

    var body: some View {
        Form {
            Section {
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date")
                }.accessibilityIdentifier(DatePickersId.datePicker.rawValue)
            }
            
            Section {
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date")
                }.accessibilityIdentifier(DatePickersId.dateWheelPicker.rawValue)
                    .datePickerStyle(.wheel)
            }
            
            Section {
                Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
                    .font(.headline)
            }
        }.navigationTitle("📅 Date Pickers")
    }
}

#Preview {
    DatePickersView()
}
