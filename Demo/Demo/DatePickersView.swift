//
//  DatePickersView.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//

import SwiftUI

enum DatePickersId : String {
    case  datePicker, dateWheelPicker, timePicker
}

struct DatePickersView: View {
    
    @State private var birthDate = Date.now
    @State private var time = Date.now

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
                    .datePickerStyle(.automatic)
            }
            
            Section {
                Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
                    .font(.headline)
            }
            
            Section {
                DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                    Text("Select a time")
                }.accessibilityIdentifier(DatePickersId.timePicker.rawValue)
                    .datePickerStyle(.automatic)

                Text("Time is \(time.formatted(date: .omitted, time: .shortened))")
                    .font(.headline)
            }
        }.navigationTitle("📅 Date Pickers")
    }
}

#Preview {
    DatePickersView()
}
