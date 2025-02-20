//
//  ImagesView.swift
//  UIPlayground
//
//  Created by Intesys on 15/01/25.
//

import SwiftUI

struct ImagesView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 2)
            Image("dog")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 2)


        }.padding(8)
        .navigationTitle("🏞️ Images")
    }
}

#Preview {
    NavigationView {
        ImagesView()
    }
}
