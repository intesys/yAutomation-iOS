//
//  YRobot+TextField.swift
//
//  Created by Davide Benini on 21/10/24.
//
import XCTest

@MainActor
public extension YRobot {

    /// Inserts the provided text into the text field matching fhe provided identifier
    /// - Parameters:
    ///   - text: The text to insert
    ///   - textFieldIdentifier: The text field identifier
    ///   - isSecure: Indicates whether the text field is secure. Defaults: false
    func insert(text: String, in textFieldIdentifier: String, isSecure: Bool = false) {
        var textField = app.textFields[textFieldIdentifier]
        if isSecure {
            textField = app.secureTextFields[textFieldIdentifier]
        }
        XCTAssert(textField.waitForExistence(timeout: 2))
        textField.insertText(text: text)
    }
    
    /// Clears the text field matcihng the givenm identifier
    /// - Parameters:
    ///   - textFieldIdentifier: The text field identifier
    ///   - isSecure: Indicates whether the text field is secure. Defaults: false
    func clear(textField textFieldIdentifier: String, isSecure: Bool = false) {
        var textField = app.textFields[textFieldIdentifier]
        if isSecure {
            textField = app.secureTextFields[textFieldIdentifier]
        }
        XCTAssert(textField.exists)
        textField.clearText()
    }
}

extension XCUIElement {
    
    /// Clears the element text
    func clearText() {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
    
    /// Insert text the provided text into the element
    /// - Parameters:
    ///   - text: The text to insert
    ///   - clear: Indicates whether the element text should be cleared first. Defaults: true
    func insertText(text: String, clear: Bool = true) {
        if clear {
            clearText()
        }
        self.tap()
        self.typeText(text)
    }

}
