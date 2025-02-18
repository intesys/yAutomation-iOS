//
//  DemoUITests.swift
//  DemoUITests
//
//  Created by Davide Benini on 16/01/25.
//

import XCTest
import YRobot
final class DemoUITests: XCTestCase {

    var bot: YRobot!
    
    @MainActor
    override func setUpWithError() throws {
        bot = YRobot(app: XCUIApplication())
        continueAfterFailure = false
        bot.launch(arguments: ["other"])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Screenshots
    @MainActor
    func testScreenshot() throws {
        bot.takeScreenshot(name: "Home", in: self)
    }
  
    
    // MARK: - Navigation
    @MainActor
    func testNavigation() throws {
        bot.tap(button: "Form")
        bot.navigateBack()
    }
    
    // MARK: - Tabs
    @MainActor
    func testTabBar() throws {
        bot.assertTabBarExists()
        bot.assertTabBarHasTabs(count: 3)
        bot.selectTab(index: 1, wait: 1)
        bot.selectTab(index: 2, wait: 2)
        bot.selectTab(index: 0, wait: 0)
    }
    
    // MARK: - Texts
    @MainActor
    func testTexts() throws {
        bot.assertHas(text: "Demo")
        bot.assertHas(text: "🤖 YRobot DemoApp", exactMatch: true, timeout: 10)
    }
    
    // MARK: - Images
    @MainActor
    func testImages() throws {
        bot.tap(button: "Images")
        bot.assertHasImages(count: 1, allowMore: true)
        bot.assertHasImages(count: 2)
    }
    
    // MARK: - Scrolling
    @MainActor
    func testScrolling() throws {
        bot.tap(button: "List")
        bot.takeScreenshot(name: "List", in: self)

        let unicornText = "🦄"
        let collectionView = bot.app.collectionViews.firstMatch
        bot.scroll(collectionView, toButtonWithTitle: unicornText)
        
        bot.tap(button: unicornText)
        bot.wait(interval: 2)
    }
    
    @MainActor
    func testScrollToTop() throws {
        bot.tap(button: "List")
        
        let collectionView = bot.app.collectionViews.firstMatch
        bot.scroll(collectionView, toButtonWithTitle: "🐔")
        
        bot.scrollToTop(collectionView)
    }
    // MARK: - Menu
    @MainActor
    func testMenu() throws {
        let menu = bot.menu(title: "Menu")
        XCTAssert(menu.exists)
        
        bot.select(item: "Item 1", inMenu: "Menu")
        bot.select(item: "Item 2", inMenu: "Menu")
        bot.select(item: "Item 3", inMenu: "Menu")

        bot.select(path: ["Sub Items", "Item 4"], inMenu: "Menu")
        bot.select(path: ["Sub Items", "Item 5"], inMenu: "Menu")
    }
    
    
    // MARK: - Search
    @MainActor
    func testSearch() throws {
        bot.tap(button: "List")
        let field = bot.firstSearchField(revealHidden: true)
        print(field)
        
        bot.insert(text: "🦊", inSearchField: field)
        print(field)

    }
    
    // MARK: - Form
    @MainActor
    func testForm() throws {
        // UI tests must launch the application that they test.
        bot.tap(button: "Form")
        bot.insert(text: "Ugobaldo", in: "firstName")
        bot.clear(textField: "firstName")
        bot.insert(text: "Marvin", in: "firstName")
        bot.insert(text: "Pantalozzi", in: "lastName")
        bot.insert(text: "34567890", in: "phoneNumber")
                
        bot.tap(button: "saveButton")
        
        bot.assertHasActivityIndicator()
        
        bot.assertHasAlert()
        bot.assertsHasAlert(withText: "Alert title")
    }
    
    // MARK: - Switch
    @MainActor
    func testSwitch() throws {
        bot.tap(button: "Controls")
        bot.takeScreenshot(name: "Controls", in: self)

        bot.toggle("toggle", wait: 2)
        
        bot.set(switch: "toggle", to: false, wait: 1)
        bot.set(switch: "toggle", to: true, wait: 1)
        bot.set(switch: "toggle", to: false, wait: 1)
        bot.set(switch: "toggle", to: false, wait: 1)
        bot.set(switch: "toggle", to: true, wait: 1)
    }
    
    // MARK: - Stepper
    @MainActor
    func testStepper() throws {
        bot.tap(button: "Controls")
        bot.assertStepperExists("stepper")
        bot.tapPlus(on: "stepper", wait: 0.5)
        bot.tapPlus(on: "stepper", wait: 0.5)
        bot.tapPlus(on: "stepper", wait: 0.5)
        bot.tapMinus(on: "stepper", wait: 0.5)
        bot.tapMinus(on: "stepper", wait: 0.5)
        bot.tapMinus(on: "stepper", wait: 0.5)
        bot.tapMinus(on: "stepper", wait: 0.5)
    }
    
    // MARK: - Slider
    @MainActor
    func testSlider() throws {
        bot.tap(button: "Controls")
        bot.assertSliderExists("slider", timeout: 100)
        bot.set(slider: "slider", to: 10, wait: 3)
    }

    // MARK: - Date Pickers
    @MainActor
    func testCalendarDatePicker() throws {
        bot.tap(button: "Date Pickers")
        bot.takeScreenshot(name: "Date Pickers", in: self)

        bot.assertDatePickerExists("datePicker")
        
        bot.select(datePickerIdentifier: "datePicker")
        
        bot.pickDateInCalendarPicker(day: 12,
                                     month: 02,
                                     year: 2014,
                                     in: "datePicker",
                                     wait: 2)
    }
    
    @MainActor
    func testWheelDatePicker() throws {
        bot.tap(button: "Date Pickers")
        
        bot.pickDateInWheelPicker(day: 8,
                                   month: 03,
                                   year: 2015,
                                   in: "dateWheelPicker",
                                   wait: 2)
    }
    // MARK: - Time Pickers
    @MainActor
    func testCompactTimePicker() throws {
        bot.tap(button: "Date Pickers")

        bot.assertDatePickerExists("timePicker")
        
        bot.select(datePickerIdentifier: "timePicker")
        
        bot.pickTimeInCompactPicker(hours: 15, minutes: 45, in: "timePicker")
    }
    
    @MainActor
    func testWheelTimePicker() throws {
        bot.tap(button: "Date Pickers")

        bot.assertDatePickerExists("timeWheelPicker")
                
        bot.pickTimeInWheelPicker(hours: 16, minutes: 25, in: "timeWheelPicker")
    }
    
    // MARK: - Items Pickers
    @MainActor
    func testListPicker() throws {
        bot.tap(button: "Pickers")
        bot.takeScreenshot(name: "Pickers", in: self)

        bot.pickInListPicker(text: "Blue",
                              in: "picker",
                              wait: 2)
    }
   
    @MainActor
    func testWheelPicker() throws {
        bot.tap(button: "Pickers")
        
        bot.pickInWheelPicker(text: "Tartan",
                               in: "wheelPicker",
                               wait: 2)
    }

    // MARK: - Alerts
    @MainActor
    func testAlerts() throws {
        bot.tap(button: "Alerts")
        bot.takeScreenshot(name: "Alerts", in: self)

        bot.tap(button: "Show Yes/No alert", wait: 2)
        bot.assertHasAlert()
        bot.tap(button: "Yes", wait: 2)
        
        bot.tap(button: "Show Yes/No alert", wait: 2)
        bot.assertAlertHasButtons(["Yes", "No"])
    }

    // MARK: - Actions Sheets
    @MainActor
    func testActionSheet() throws {
        bot.tap(button: "Alerts")
        bot.tap(button: "Show color options", wait: 1)
        bot.assertActionSheetExists()
        bot.tap(button: "🟩 Green", wait: 2)
        
        bot.tap(button: "Show color options", wait: 2)
        bot.assertActionSheetHasButtons(["🟥 Red", "🟩 Green", "🟨 Yellow"])
    }
}
