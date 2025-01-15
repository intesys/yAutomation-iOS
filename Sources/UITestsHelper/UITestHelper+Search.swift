//
//  UITestHelper+Search.swift
//  UITestsHelper
//
//  Created by Davide Benini on 15/01/25.
//
import XCTest

@MainActor
public extension UITestsHelper {
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
    
    func insert(text: String, inSearchField searchField: XCUIElement) {
        XCTAssert(searchField.waitForExistence(timeout: 2))
        searchField.insertText(text: text)
    }
    
    func insert(text: String, inSearchFieldIdentifiedBy identifier: String) {
        var field = app.searchFields[identifier]
        XCTAssert(field.waitForExistence(timeout: 2))
        insert(text: text, inSearchField: field)
    }
}
