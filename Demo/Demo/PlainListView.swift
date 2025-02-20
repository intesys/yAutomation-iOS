//
//  PlainListView.swift
//  Sandboxer
//
//  Created by Intesys on 21/10/24.
//

import SwiftUI

struct PlainListView: View {
    @State var selection: String? = "🐱"
    @State private var searchText = ""
    let animals = [
        "🐶🐱","🐱🐱","🐭🐱","🐹","🐰🦊","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐗","🐴","🦄","🐞","🐝","🐔","🦆","🐌","🦋","🐙","🐠","🦀","🐳"
    ]
    var body: some View {
        List {
            ForEach(Array(items().enumerated()), id: \.element) { index, element in
                Button(action: {
                    self.selection = element
                }) {
                    HStack {
                        
                        Text(items()[index])
                            .font(.largeTitle)
                        Spacer()
                        if selection == element {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.accentColor)
                        } else {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.clear)

                        }
                    }
                }
            }
        }.navigationTitle("📋 List")
        .searchable(text: $searchText)
    }
    
    func items() -> [String] {
        guard !searchText.isEmpty else {
            return animals
        }
        return animals.filter({ $0.contains(searchText)})
    }
}

#Preview {
    PlainListView()
}
