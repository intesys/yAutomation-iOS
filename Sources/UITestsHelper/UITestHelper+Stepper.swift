//
//  UITestHelper+Stepper.swift
//  Sandboxer
//
//  Created by Davide Benini on 24/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    
    /// Asserts that a stepper with the provided identifier is present on screen
    /// - Parameters:
    ///   - stepperIdentifier: The stepper identifier
    ///   -  timeout: The timeout to wait for the element existence. Defaults: 0
    func assertStepperExists(_ stepperIdentifier: String, timeout: TimeInterval = 0) {
        let stepper = app.steppers.matching(identifier: stepperIdentifier).firstMatch
        XCTAssert(stepper.waitForExistence(timeout: timeout))
    }
    
    /// Taps plus on the stepper matching the given identifier
    /// - Parameters:
    ///   - stepperIdentifier: The stepper identifier
    ///   - wait: Optional: a delay which will be applied after the button has been tapped
    func tapPlus(on stepperIdentifier: String, wait: TimeInterval? = nil) {
        let stepper = app.steppers.matching(identifier: stepperIdentifier).firstMatch
        XCTAssert(stepper.exists)
    
        let plusButton = stepper.buttons["stepper-Increment"]
        plusButton.tap()
        
        waitIfAny(wait)
    }
    
    /// Taps minus on the stepper matching the given identifier
    /// - Parameters:
    ///   - stepperIdentifier: The stepper identifier
    ///   - wait: Optional: a delay which will be applied after the button has been tapped
    func tapMinus(on stepperIdentifier: String, wait: TimeInterval? = nil) {
        let stepper = app.steppers.matching(identifier: stepperIdentifier).firstMatch
        XCTAssert(stepper.exists)
    
        let minusButton = stepper.buttons["stepper-Decrement"]
        minusButton.tap()
        
        waitIfAny(wait)
    }
}
