//
//  CreditsView.swift
//  UIPlayground
//
//  Created by Davide Benini on 15/01/25.
//
import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("YRobot was developed by Intesys for UI-testing its projects.")
                Spacer()
            }
            .padding()
            .navigationTitle("📋 Credits")
        }
    }
}

#Preview {
    CreditsView()
}
