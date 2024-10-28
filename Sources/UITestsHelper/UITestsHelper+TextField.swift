//
//  UITestsHelper+TextField.swift
//  Sandboxer
//
//  Created by Davide Benini on 21/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func insert(text: String, in textFieldIdentifier: String) {
        let textField = app.textFields[textFieldIdentifier]
        XCTAssert(textField.waitForExistence(timeout: 2))
        textField.insertText(text: text)
    }
    func clear(textField textFieldIdentifier: String) {
        let textField = app.textFields[textFieldIdentifier]
        XCTAssert(textField.exists)
        textField.clearText()
    }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
    
    func insertText(text: String, clear: Bool = true) {
        if clear {
            clearText()
        }
        self.tap()
        self.typeText(text)
    }

}
