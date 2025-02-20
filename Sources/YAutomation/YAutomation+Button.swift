//
//  YAutomation+Button.swift
//
//  Created by Intesys on 21/10/24.
//
import XCTest

@MainActor
public extension YAutomation {

    /// Asserts that a button with the provided identifier is present on screen
    /// - Parameters:
    ///   - buttonIdentifier: The date picker identifier
    ///   - timeout: The timeout to wait for the element existence. Defaults: 0
    func assertButtonExists(_ buttonIdentifier: String, timeout: TimeInterval = 0) {
        let picker = app.buttons.matching(identifier: buttonIdentifier).firstMatch
        XCTAssert(picker.waitForExistence(timeout: timeout))
    }
    
    /// Taps the button with the provided identifier
    /// - Parameters:
    ///   - identifier: The button identifier
    ///   - wait: An optional delay after the tap
    func tap(button identifier: String, wait: TimeInterval? = nil) {
        let button = app.buttons.matching(identifier: identifier).firstMatch
        XCTAssert(button.exists)
        button.tap()
        
        waitIfAny(wait)
    }

}
