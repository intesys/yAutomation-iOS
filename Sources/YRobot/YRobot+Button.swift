//
//  YRobot+Button.swift
//
//  Created by Davide Benini on 21/10/24.
//
import XCTest

@MainActor
public extension YRobot {

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
