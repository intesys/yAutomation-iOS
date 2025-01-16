//
//  YRobot.swift
//
//  Created by Davide Benini on 21/10/24.
//
import XCTest
public struct YRobotConfiguration {
    
    public static let defaultLoaderIdentifier = "loader"
    public static let defaultBackButtonIdentifier = "backButton"
    public static let defaultScrollingVelocity: XCUIGestureVelocity = 200
    
    var loaderIdentifier: String
    var backButtonIdentifier: String
    var scrollingVelocity: XCUIGestureVelocity

    public static var defaultConfiguration: YRobotConfiguration {
        YRobotConfiguration(loaderIdentifier: YRobotConfiguration.defaultLoaderIdentifier,
                            backButtonIdentifier: YRobotConfiguration.defaultBackButtonIdentifier ,
                            scrollingVelocity: YRobotConfiguration.defaultScrollingVelocity)
    }
}


public class YRobot {
    public var app: XCUIApplication
    public var configuration: YRobotConfiguration = .defaultConfiguration
    
    public init(app: XCUIApplication, configuration: YRobotConfiguration = .defaultConfiguration) {
        self.app = app
        self.configuration = configuration
    }
}

@MainActor
public extension YRobot {
  
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
