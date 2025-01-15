//
//  UITestHelper+Search.swift
//  UITestsHelper
//
//  Created by Davide Benini on 15/01/25.
//
import XCTest

@MainActor
public extension UITestsHelper {
    
    /// Returns the first text field on the screen
    /// - Parameter revealHidden: whether to scroll down to reveal a hidden table text field
    /// - Returns: the serach field
    func firstSearchField(revealHidden: Bool) -> XCUIElement {
        var field =  app.searchFields.firstMatch
        if field.exists {
            return field
        }
        let scrollView = app.collectionViews.firstMatch
        scrollView.swipeDown()
        field =  app.searchFields.firstMatch
        return field
    }
    
    /// Inserts a given text into the provided text field
    /// - Parameters:
    ///   - text: The text to search
    ///   - searchField: The text field
    func insert(text: String, inSearchField searchField: XCUIElement) {
        XCTAssert(searchField.exists)
        searchField.insertText(text: text)
    }
    
    /// Inserts a given text into the the text field with the given identifier
    /// - Parameters:
    ///   - text: The text to search
    ///   - identifier: The text field identifier
    func insert(text: String, inSearchFieldIdentifiedBy identifier: String) {
        let field = app.searchFields[identifier]
        XCTAssert(field.exists)
        insert(text: text, inSearchField: field)
    }

}
