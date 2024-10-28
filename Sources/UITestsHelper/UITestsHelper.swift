//
//  UITestsHelper.swift
//  Sandboxer
//
//  Created by Davide Benini on 21/10/24.
//
import XCTest
public struct HelperConfiguration {
    var loaderIdentifier: String
    var backButtonIdentifier: String
    var scrollingVelocity: XCUIGestureVelocity

    public static var defaultConfiguration: HelperConfiguration {
        HelperConfiguration(loaderIdentifier: "Loader",
                            backButtonIdentifier: "BackButton",
                            scrollingVelocity: 200)
    }
}


public class UITestsHelper {
    public var app: XCUIApplication
    public var configuration: HelperConfiguration = .defaultConfiguration
    
    public init(app: XCUIApplication, configuration: HelperConfiguration) {
        self.app = app
        self.configuration = configuration
    }
}

@MainActor
public extension UITestsHelper {
  
    func launch() {
        app.launch()
    }
    
    func checkHasLoader() {
        let loader = app.activityIndicators[configuration.loaderIdentifier]
        XCTAssert(loader.waitForExistence(timeout: 1))
    }
    
    func wait(interval: TimeInterval) {
        sleep(UInt32(interval))
    }
    func navigateBack() {
        tap(button: configuration.backButtonIdentifier)
    }
    
    func waitIfAny(_ interval: TimeInterval?) {
        if let interval {
            sleep(UInt32(interval))
        }
    }
    
    func takeScreenshot(name: String, in testCase: XCTestCase) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        testCase.add(attachment)
    }
}
