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
            Text("These are some info, TODO")
                .navigationTitle("ℹ️ Info")
        }
    }
}

#Preview {
    InfoView()
}
