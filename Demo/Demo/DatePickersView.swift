//
//  DatePickersView.swift
//  Sandboxer
//
//  Created by Intesys on 28/10/24.
//

import SwiftUI

enum DatePickersId : String {
    case  datePicker, dateWheelPicker, timePicker, timeWheelPicker
}

struct DatePickersView: View {
    
    @State private var birthDate = Date.now
    @State private var time = Date.now

    var body: some View {
        Form {
            Section {
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date")
                }.datePickerStyle(.compact)
                .accessibilityIdentifier(DatePickersId.datePicker.rawValue)
      
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date")
                }.accessibilityIdentifier(DatePickersId.dateWheelPicker.rawValue)
                    .datePickerStyle(.wheel)
                Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
                    .font(.headline)
            }
            
            Section {
                DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                    Text("Select a time")
                }.accessibilityIdentifier(DatePickersId.timePicker.rawValue)
                    .datePickerStyle(.compact)
  
                DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                    Text("Select a time")
                }.datePickerStyle(.wheel)
                .accessibilityIdentifier(DatePickersId.timeWheelPicker.rawValue)
   
                Text("Time is \(time.formatted(date: .omitted, time: .shortened))")
                    .font(.headline)
            }
        }.navigationTitle("📅 Date Pickers")
    }
}

#Preview {
    DatePickersView()
}
