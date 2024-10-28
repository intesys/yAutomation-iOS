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
    @MainActor public func launch() {
        app.launch()
    }
}

@MainActor
public extension UITestsHelper {
  
    func checkHasLoader() {
        let loader = app.activityIndicators[configuration.loaderIdentifier]
        XCTAssert(loader.waitForExistence(timeout: 1))
    }
    
    func pause(interval: TimeInterval) {
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
}
