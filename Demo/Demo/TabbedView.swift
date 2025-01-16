//
//  TabView.swift
//  UIPlayground
//
//  Created by Davide Benini on 15/01/25.
//

import SwiftUI

struct TabbedView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
            
            CreditsView()
                .tabItem {
                    Label("Credits", systemImage: "text.bubble")
                }
        }
        .withToasts(alignment: .bottom)
    }
}

#Preview {
    TabbedView()
}
