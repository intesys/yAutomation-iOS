//
//  UITestsHelper.swift
//  Sandboxer
//
//  Created by Davide Benini on 21/10/24.
//
import XCTest
public struct UITestsHelperConfiguration {
    
    public static let defaultLoaderIdentifier = "loader"
    public static let defaultBackButtonIdentifier = "backButton"
    public static let defaultScrollingVelocity: XCUIGestureVelocity = 200
    
    var loaderIdentifier: String
    var backButtonIdentifier: String
    var scrollingVelocity: XCUIGestureVelocity

    public static var defaultConfiguration: UITestsHelperConfiguration {
        UITestsHelperConfiguration(loaderIdentifier: UITestsHelperConfiguration.defaultLoaderIdentifier,
                                   backButtonIdentifier: UITestsHelperConfiguration.defaultBackButtonIdentifier ,
                                   scrollingVelocity: UITestsHelperConfiguration.defaultScrollingVelocity)
    }
}


public class UITestsHelper {
    public var app: XCUIApplication
    public var configuration: UITestsHelperConfiguration = .defaultConfiguration
    
    public init(app: XCUIApplication, configuration: UITestsHelperConfiguration = .defaultConfiguration) {
        self.app = app
        self.configuration = configuration
    }
}

@MainActor
public extension UITestsHelper {
  
    func launch() {
        app.launch()
    }
    
    func assertHasActivityIndicator() {
        let loader = app.activityIndicators[configuration.loaderIdentifier]
        XCTAssert(loader.waitForExistence(timeout: 1))
    }
    
    func wait(interval: TimeInterval) {
        waitIfAny(interval)
    }
    
    func waitIfAny(_ interval: TimeInterval?) {
        if let interval {
            sleep(UInt32(interval))
        }
    }

    func navigateBack() {
        tap(button: configuration.backButtonIdentifier)
    }
    
    func takeScreenshot(name: String, in testCase: XCTestCase) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        testCase.add(attachment)
    }
}
