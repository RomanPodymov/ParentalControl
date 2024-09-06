//
//  ParentalControlTests.swift
//  ParentalControlTests
//
//  Created by Roman Podymov on 28/08/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import ParentalControlAppMacOS
import XCTest

class ParentalControlTests: XCTestCase {
    func testOpenScreen() {
        // Given
        let appDelegate = AppDelegate()

        // When
        appDelegate.openMainScreen()

        // Then
        XCTAssertNotNil(appDelegate.window?.rootViewController)
    }
}
