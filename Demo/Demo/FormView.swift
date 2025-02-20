//
//  ContentView.swift
//  Sandboxer
//
//  Created by Intesys on 21/10/24.
//

import SwiftUI
import yAutomationConfigurator

func delay(_ seconds: Double, queue: DispatchQueue = DispatchQueue.main, block: @escaping () -> Void) {
    queue.asyncAfter(deadline: .now() + seconds) {
        block()
    }
}

enum FormId : String {
    case firstName
    case lastName
    case phoneNumber
    case isActive
}
struct FormView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var phoneNumber: String = ""
    @State var isActive: Bool = false

    @State var isLoading: Bool = false
    @State var showingAlert: Bool = false

    var body: some View {
        Form {
            FieldWithLegend(id: FormId.firstName.rawValue,
                            legend: "First Name",
                            value: $firstName)
            FieldWithLegend(id: FormId.lastName.rawValue,
                            legend: "Last Name",
                            value: $lastName)
            FieldWithLegend(id: FormId.phoneNumber.rawValue,
                            legend: "Phone Number",
                            value: $phoneNumber)
            ToggleWithLegend(id: FormId.isActive.rawValue, legend: "Active", value: $isActive)
            Button(action: { postData() }) {
                Text("Send")
            }.accessibilityIdentifier("saveButton")
        }
        .alert("Alert title", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
        }
        .navigationTitle("🗒️ Form")
        .withAccessibleBackButton(title: "Home")
        .withLoader(loading: $isLoading)
    }
    
    func postData() {
        isLoading = true
        delay(3) {
            isLoading = false
            showingAlert = true
        }
    }
}

#Preview {
    FormView()
}

struct FieldWithLegend: View {
    var id: String
    var legend: String
    @Binding var value: String

    var placeholder: String {
        "Insert " + legend.lowercased()
    }
    var body: some View {
        Section(header: Text(legend)) {
            HStack {
                TextField(placeholder, text: $value)
                    .textFieldStyle(.plain)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier(id)
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.green)
                    .opacity(value.count > 1 ? 1.0 : 0.0)
            }
        }
        
    }
}

struct ToggleWithLegend: View {
    var id: String
    var legend: String
    @Binding var value: Bool

    var placeholder: String {
        "Insert " + legend.lowercased()
    }
    var body: some View {
        Section(header: Text(legend)) {
            Toggle("Is Active?", isOn: $value)
                .accessibilityIdentifier(id)
        }
    }
}
