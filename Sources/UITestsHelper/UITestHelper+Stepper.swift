//
//  UITestHelper+Stepper.swift
//  Sandboxer
//
//  Created by Davide Benini on 24/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func tapPlus(on stepperIdentifier: String, wait: TimeInterval? = nil) {
        let stepper = app.steppers.matching(identifier: stepperIdentifier).firstMatch
        XCTAssert(stepper.exists)
    
        let plusButton = stepper.buttons["stepper-Increment"]
        plusButton.tap()
        
        waitIfAny(wait)
    }
    
    func tapMinus(on stepperIdentifier: String, wait: TimeInterval? = nil) {
        let stepper = app.steppers.matching(identifier: stepperIdentifier).firstMatch
        XCTAssert(stepper.exists)
    
        let minusButton = stepper.buttons["stepper-Decrement"]
        minusButton.tap()
        
        waitIfAny(wait)
    }
}
