//
//  Untitled.swift
//  Sandboxer
//
//  Created by Davide Benini on 21/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func tap(button identifier: String, wait: TimeInterval? = nil) {
        let button = app.buttons.matching(identifier: identifier).firstMatch
        XCTAssert(button.exists)
        button.tap()
        
        waitIfAny(wait)

    }
}
