//
//  UITestsHelper+Menu.swift
//  UITestsHelper
//
//  Created by Davide Benini on 15/01/25.
//

import XCTest

@MainActor
public extension UITestsHelper {
    func menu(title: String) -> XCUIElement {
        app.buttons[title].firstMatch
    }
    func select(item: String, inMenu menu: String) {
        select(submenuPath: [item], inMenu: menu)
    }
    
    func select(submenuPath: [String], inMenu menu: String) {
        let menu = app.buttons[menu].firstMatch
        XCTAssert(menu.exists)
        menu.tap()
        
        for pathItem in submenuPath {
            let itemElement = app.buttons[pathItem]
            itemElement.tap()
        }

    }

}
