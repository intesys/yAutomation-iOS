//
//  View+Loading.swift
//  Sandboxer
//
//  Created by Intesys on 21/10/24.
//

import SwiftUI
import yAutomationConfigurator

struct Loader: ViewModifier {
    @Binding var loading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            
            if loading {
                Color(UIColor(white: 0.0, alpha: 0.5))
                    .ignoresSafeArea()
                
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .makeAccessible(.loader)
            }
        }
    }
}

extension View {
    func withLoader(loading: Binding<Bool>) -> some View {
        modifier(Loader(loading: loading))
    }
}
