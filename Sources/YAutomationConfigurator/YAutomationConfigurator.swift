//
//  UITestHelperConfigurator.swift
//  UITestsHelper
//
//  Created by Intesys on 14/01/25.
//
import SwiftUI

public enum AccessibleElement: String {
    case backButton
    case loader
}

struct AccessibleModifier: ViewModifier {
    var element: AccessibleElement
    func body(content: Content) -> some View {
        content
            .accessibilityIdentifier(element.rawValue)
    }
}

public extension View {
    func makeAccessible(_ element: AccessibleElement) -> some View {
        modifier(AccessibleModifier(element: element))
    }
}

struct AccessibleBackButtonModifier: ViewModifier {
    var title: String?
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .makeAccessible(.backButton)
                    if let title {
                        Text(title)
                    }
                }
            })
    }
}

public extension View {
    func withAccessibleBackButton(title: String? = nil) -> some View {
        modifier(AccessibleBackButtonModifier(title: title))
    }
}

public func isRunningYAutomationTests() -> Bool {
    return ProcessInfo.processInfo.arguments.contains("--yautomation")
}

public func isRunningWith(argument: String) -> Bool {
    var arg = argument
    if !arg.hasPrefix("--") {
        arg = "--".appending(arg)
    }
    return ProcessInfo.processInfo.arguments.contains(arg)
}
