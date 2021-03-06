/* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class AsianLocaleTest: BaseTestCase {
	
	override func setUp() {
		super.setUp()
		dismissFirstRunUI()
	}
	
	override func tearDown() {
		app.terminate()
		super.tearDown()
	}
 
	func testSearchinLocale() {
		
        // Set search engine to Google
		app.buttons["Settings"].tap()
		app.tables.cells["SettingsViewController.searchCell"].tap()
	
		app.tables.staticTexts["Google"].tap()
		app.navigationBars["Settings"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        
		// Enter 'mozilla' on the search field
		search(searchWord: "모질라")
		search(searchWord: "モジラ")
		search(searchWord: "因特網")
	}
	
	func search(searchWord: String) {
		let app = XCUIApplication()
		
		let searchOrEnterAddressTextField = app.textFields["Search or enter address"]
		XCTAssertTrue(searchOrEnterAddressTextField.exists)
		XCTAssertTrue(searchOrEnterAddressTextField.isEnabled)
		
		// Check the text autocompletes to mozilla.org/, and also look for 'Search for mozilla' button below
        searchOrEnterAddressTextField.tap()
		searchOrEnterAddressTextField.typeText(searchWord)
		waitforExistence(element: app.buttons["Search for " + searchWord])
		app.buttons["Search for " + searchWord].tap()
        
        // Check the correct site is reached
        if (iPad()) {
            waitforExistence(element: app.webViews.textFields["Search"])
            app.webViews.textFields["Search"].tap()
            waitForValueContains(element: app.webViews.textFields["Search"], value: searchWord)
        } else {
            waitforExistence(element: app.webViews.searchFields["Search"])
            app.webViews.searchFields["Search"].tap()
            waitForValueContains(element: app.webViews.searchFields["Search"], value: searchWord)
        }
        
		// Erase the history
		app.buttons["ERASE"].tap()
		XCTAssertTrue(app.staticTexts["Your browsing history has been erased."].exists)
		
		// Check it is on the initial page
		XCTAssertTrue(app.staticTexts["Browse. Erase. Repeat."].exists)
		XCTAssertTrue(app.staticTexts["Automatic private browsing."].exists)
	}
}
