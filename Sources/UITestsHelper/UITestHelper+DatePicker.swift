//
//  UITestHelper+DatePicker.swift
//  Sandboxer
//
//  Created by Davide Benini on 24/10/24.
//
import Foundation
import XCTest

@MainActor
public extension UITestsHelper {
    func select(datePickerIdentifier: String, wait: TimeInterval? = nil) {
        let picker = app.datePickers.matching(identifier: datePickerIdentifier).firstMatch
        XCTAssert(picker.exists)
        
        picker.tap()
        
        waitIfAny(wait)

    }
    
    func pickDateInCalendarPicker(day: Int, month: Int, year: Int, in datePickerIdentifier: String, wait: TimeInterval? = nil) {
        
        let tappedPicker = app.datePickers.matching(identifier: datePickerIdentifier).firstMatch
        XCTAssert(tappedPicker.exists)

        guard let selectionPicker = app.datePickers.allElementsBoundByAccessibilityElement.filter({ $0 != tappedPicker }).first else {
            XCTFail("Cannot get selection picker")
            return
        }
     
        setCalendarDatePicker(month: month, year: year, picker: selectionPicker)
        
        let monthName = localizedMonthName(month).capitalized(with: Locale.current)
        let dayMonthString = "\(day) \(monthName)"
        let dayButton = app.buttons.matching(NSPredicate(format: "label CONTAINS '\(dayMonthString)'")).firstMatch
        dayButton.tap()
        
        app.buttons["PopoverDismissRegion"].firstMatch.tap()
      
        waitIfAny(wait)
    }
    
    private func setCalendarDatePicker(month: Int, year: Int, picker: XCUIElement) {
        var monthYearButton = picker.buttons["DatePicker.Show"].firstMatch

        guard let selectedMonthYear = monthYearButton.value as? String else {
            return
        }

        if monthYearButton.exists {
            monthYearButton.tap()
        }
        
        let elements = selectedMonthYear.split(separator: " ").map({ String($0)})
        
        guard let selectedYear = elements.first(where: { Int($0) != nil }) else {
            return
        }
        let selectedMonth = selectedMonthYear.replacingOccurrences(of: selectedYear, with: "").trimmingCharacters(in: .whitespaces)
        let monthSelector = app.pickerWheels.matching(NSPredicate(format: "value = '\(selectedMonth)'")).firstMatch
        let yearSelector = app.pickerWheels.matching(NSPredicate(format: "value = '\(selectedYear)'", selectedYear)).firstMatch

        let monthName = localizedMonthName(month).capitalized(with: Locale.current)
        monthSelector.adjust(toPickerWheelValue: monthName)
        
        yearSelector.adjust(toPickerWheelValue: "\(year)")
        
        monthYearButton = picker.buttons["DatePicker.Hide"].firstMatch
        monthYearButton.tap()
    }
    
    func pickDateInWheelPicker(day: Int, month: Int, year: Int, in datePickerIdentifier: String, wait: TimeInterval? = nil) {
        
        let picker = app.datePickers.matching(identifier: datePickerIdentifier).firstMatch
        XCTAssert(picker.exists)
        
        let dayWheel = picker.pickerWheels.allElementsBoundByIndex[0]
        dayWheel.adjust(toPickerWheelValue: "\(day)")

        let monthWheel = picker.pickerWheels.allElementsBoundByIndex[1]
        let monthName = localizedMonthName(month).capitalized(with: Locale.current)
        monthWheel.adjust(toPickerWheelValue: monthName)

        let yearWheel = picker.pickerWheels.allElementsBoundByIndex[2]
        yearWheel.adjust(toPickerWheelValue: "\(year)")

        waitIfAny(wait)

    }
    private func localizedMonthName(_ number: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")//Locale.current
        let monthName = dateFormatter.standaloneMonthSymbols[number - 1]
        return monthName
    }
}
