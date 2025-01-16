//
//  ControlsView.swift
//  Sandboxer
//
//  Created by Davide Benini on 24/10/24.
//

import SwiftUI

enum ControlsId : String {
    case toggle, stepper, slider
}
struct ControlsView: View {
    @State var toggleIsOn: Bool = false
    
    @State private var speed = 40.0
    @State private var isEditingSpeed = false
    
    @State private var sleepAmount = 8.0

    var body: some View {
        Form {
            Toggle("Toggle", isOn: $toggleIsOn)
                .accessibilityIdentifier(ControlsId.toggle.rawValue)
            
            VStack {
                Slider(
                    value: $speed,
                    in: 0...50,
                    step: 1,
                    onEditingChanged: { editing in
                        isEditingSpeed = editing
                    }
                ).accessibilityIdentifier(ControlsId.slider.rawValue)
                Text("\(speed)")
                    .foregroundColor(isEditingSpeed ? .red : .blue)
            }
            
            Stepper("\(sleepAmount.formatted()) steps", value: $sleepAmount, step: 0.25)
                .accessibilityIdentifier(ControlsId.stepper.rawValue)
            
            Spacer()
        }.navigationTitle("🎛️ Controls")
    }
}

#Preview {
    NavigationStack {
        ControlsView()
    }
}
