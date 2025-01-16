//
//  AlertsView.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//

import SwiftUI

struct AlertsView: View {
    @State var showYesNoAlert: Bool = false

    @State private var showingColorOptions = false
    @State private var resultString = ""
    @State private var resultColor = Color.gray

    var body: some View {
        Form {
            Section(content: {
                Button("Show Yes/No alert") {
                    showYesNoAlert = true
                }.alert(isPresented: $showYesNoAlert) {
                    Alert(
                        title: Text("Is it a yes or a no?"),
                        message: Text("There is no undo"),
                        primaryButton: .destructive(Text("Yes")) {
                            resultString = "Yes tapped"
                            resultColor = .mint
                        },
                        secondaryButton: .default(Text("No"), action: {
                            resultString = "No tapped"
                            resultColor = .gray
                        })
                    )
                }
                
                Button("Show color options") {
                    showingColorOptions = true
                }.confirmationDialog("Select a color", isPresented: $showingColorOptions, titleVisibility: .visible) {
                    Button("🟥 Red") {
                        resultString = "Red tapped"
                        resultColor = .red
                    }
                    
                    Button("🟩 Green") {
                        resultString = "Green tapped"
                        resultColor = .green
                    }
                    
                    Button("🟨 Yellow") {
                        resultString = "Yellow tapped"
                        resultColor = .yellow
                    }
                }
            }, footer: {
                Text(resultString).foregroundStyle(resultColor)
            })
                    
            
        }.navigationTitle("Alerts")
             
    }
}

#Preview {
    AlertsView()
}
