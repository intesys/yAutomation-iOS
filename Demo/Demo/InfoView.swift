//
//  InfoView.swift
//  UIPlayground
//
//  Created by Davide Benini on 15/01/25.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Some general infos.\n\nThis screen was added mostly to showcase the usage of tabs.")
                Spacer()
            }
            .padding()
            .navigationTitle("ℹ️ Info")
        }
    }
}

#Preview {
    InfoView()
}
