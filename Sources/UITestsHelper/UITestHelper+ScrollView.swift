//
//  UITestHelper+ScrollView.swift
//  Sandboxer
//
//  Created by Davide Benini on 23/10/24.
//
import XCTest


public enum ScrollDirection {
    case up, down, left, right
}

@MainActor
public extension UITestsHelper {
    func scroll(_ scrollable: XCUIElement, toButtonWithTitle title: String, direction: ScrollDirection = .down, velocity: XCUIGestureVelocity? = nil) {
        guard scrollable.elementType == .scrollView || scrollable.elementType == .table || scrollable.elementType == .collectionView else {
            XCTFail("Element is not scrollable")
            return
        }
        let scrollVelocity = velocity ?? configuration.scrollingVelocity
        scrollable.scrollToButtonWith(title: title, velocity: scrollVelocity)
    }
    
    func scrollToFirstElement(_ scrollable: XCUIElement, horizontally: Bool = false) {
        guard scrollable.elementType == .scrollView || scrollable.elementType == .table || scrollable.elementType == .collectionView else {
            XCTFail("Element is not scrollable")
            return
        }
        scrollable.scrollToFirstItem(horizontally: horizontally)
    }
}

public extension XCUIElement {
    func scrollToButtonWith(title: String,
                         direction: ScrollDirection = .down,
                         velocity: XCUIGestureVelocity) {
        let element = self.buttons[title]
        
        while !element.visible() {
            switch(direction) {
            case .down:
                swipeUp(velocity: velocity)
            case .up:
                swipeDown()
            case .left:
                swipeRight()
            case .right:
                swipeLeft()
            }
        }
        
    }

    func scrollToFirstItem(horizontally: Bool = false) {
        var beforeButton: XCUIElement?
        var afterButton: XCUIElement?
        
        beforeButton = self.buttons.allElementsBoundByIndex.first(where: { $0.visible() } )

        while beforeButton?.label != afterButton?.label {
       
            beforeButton = self.buttons.allElementsBoundByIndex.first(where: { $0.visible() } )

            if horizontally {
                swipeRight()
            } else {
                swipeDown()
            }
            
            afterButton = self.buttons.allElementsBoundByIndex.first(where: { $0.visible() } )

        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
