# UITestsHelper

A simple library to make it easier to implemnt UI Tests.

The library implements a `UITestsHelper` class that can be used to simplify the most common UI interactions.

## Usage

In the typical usage, UITestsHelper is initialized in the `setUpWithError` method of the XCTestCase subclass.

    var bot: UITestsHelper!

    @MainActor
    override func setUpWithError() throws {
        bot = UITestsHelper(app: XCUIApplication())
        bot.launch()
        ...
    }

Then the helper is invoked one or more times in different test cases.  
See the following example:

    @MainActor
    func testNavigation() throws {
        bot.tap(button: "Form")
        bot.navigateBack()
    }
    
For more examples and details, see the demo project.

## Project configuration
In order to use some of the app helpers, some UI elements must be properly configured in the codebase to be tested.



### Back buttons

UITestsHelper provides a custom accessible back button that is preconfigured to be used in UI testing.

    import UITestsHelperConfigurator
    
    struct MyView {
        var body: some View {
            InnerView()
                .withAccessibleBackButton(title: "Home")
        }
    }

Alternatively, a given element can be made accessible with this helper:

Back button:

        makeAccessible(.backButton )

Loader

        makeAccessible(.loader)
      
In case a specific accessibility identifier is needed for back buttons and sliders, `UITestsHelper` can be configured to use different identifier when initialized.

