//
//  BDDTests.swift
//  Sandboxer
//
//  Created by Intesys on 30/10/24.
//

import XCTest
import XCTest_Gherkin
@testable import Demo
import yAutomation

class BDDTests: XCTestCase {
    
    var inty: YAutomation!
    
    @MainActor
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func test_controls() {
       
        NativeRunner.runScenario(featureFile: "gherkin.feature",
                                 scenario: "go to list",
                                 testCase: self)
    }
    
    func test_engine() {
       
        NativeRunner.runScenario(featureFile: "gherkin.feature",
                                 scenario: "test Engine",
                                 testCase: self)
    }
}

private final class StepsDefinition: StepDefiner {
    
    var bot: YAutomation!

    required init(test: XCTestCase, regexOptions: NSRegularExpression.Options = [.caseInsensitive]) {
        let configuration = YAutomationConfiguration.defaultConfiguration
        bot = YAutomation(app: XCUIApplication(), configuration: configuration)

        super.init(test: test, regexOptions: regexOptions)
        
    }
    
    
        
    override func defineSteps() {
        MainActor.assumeIsolated {
            self.step("I tap '(.+)'") { (buttonName: String) in
                self.bot.tap(button: buttonName)
            }
            self.step("I see '(.+)'") { (text: String) in
                XCTAssert(self.bot.app.staticTexts[text].firstMatch.exists)
            }
            
            self.step("I am in the homepage") {
                
            }
            
            self.step("I use Engine.increment") {
                Engine.shared.increment()
            }
            self.step("Engine.count is 1") {
                XCTAssert(Engine.shared.count == 1)
            }
        }
    }
}

class Engine {
    static let shared = Engine()
    var count: Int = 0
    func increment() {
        count += 1
    }
}
