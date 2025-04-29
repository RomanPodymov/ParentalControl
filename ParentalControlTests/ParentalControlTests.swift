//
//  ParentalControlTests.swift
//  ParentalControlTests
//
//  Created by Roman Podymov on 28/08/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

#if canImport(ParentalControlAppMacOS)
    @testable import ParentalControlAppMacOS
#elseif canImport(ParentalControlApp)
    @testable import ParentalControlApp
#endif
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
