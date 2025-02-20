//
//  CreditsView.swift
//  UIPlayground
//
//  Created by Intesys on 15/01/25.
//
import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("yAutomation was developed by Intesys for UI-testing its projects.")
                
                Text("The [cat photo](https://unsplash.com/it/foto/gatto-in-bianco-e-nero-sdraiato-su-una-sedia-di-bambu-marrone-allinterno-della-stanza-gKXKBY-C-Dk?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash) in the images section is from [Manja Vitolic](https://unsplash.com/it/@madhatterzone?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)")
                
                Text("The [dog photo](https://unsplash.com/it/foto/labrador-retriever-cioccolato-adulto-v3-zcCWMjgM?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash) in the images section is from [James Barker](https://unsplash.com/it/@barkernotbaker?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)")
                
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
