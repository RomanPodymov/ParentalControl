//
//  ColorsConfiguration.swift
//  ParentalControl
//
//  Created by Roman Podymov on 24/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

enum Configuration {
    static var isParentApp = true
}

#if canImport(UIKit)
    import UIKit
#endif
import CommonAppleKit

enum FontsConfiguration {
    static let labelFont = CAFont.systemFont(ofSize: 20, weight: .medium)
    static let labelSubFont = CAFont.systemFont(ofSize: 18, weight: .regular)
    static let textFieldFont = labelFont
    static let buttonFont = CAFont.systemFont(ofSize: 20, weight: .semibold)
}

enum ColorsConfiguration {
    static func backgroundColor(traitCollection: CATraitCollection) -> CAColor {
        backgroundColor(userInterfaceStyle: traitCollection.userInterfaceStyle)
    }

    static func backgroundColor(userInterfaceStyle: CAUserInterfaceStyle) -> CAColor {
        switch userInterfaceStyle {
        case .dark:
            .black
        case .light, .unspecified:
            .white
        @unknown default:
            .white
        }
    }

    static func textBackgroundColor(traitCollection: CATraitCollection) -> CAColor {
        textBackgroundColor(userInterfaceStyle: traitCollection.userInterfaceStyle)
    }

    static func textBackgroundColor(userInterfaceStyle: CAUserInterfaceStyle) -> CAColor {
        switch userInterfaceStyle {
        case .dark:
            .lightGray
        case .light, .unspecified:
            .lightGray
        @unknown default:
            .lightGray
        }
    }

    static func textColor(traitCollection: CATraitCollection) -> CAColor {
        textColor(userInterfaceStyle: traitCollection.userInterfaceStyle)
    }

    static func textColor(userInterfaceStyle: CAUserInterfaceStyle) -> CAColor {
        switch userInterfaceStyle {
        case .dark:
            .white
        case .light, .unspecified:
            .black
        @unknown default:
            .black
        }
    }

    static func textPlaceholderColor(traitCollection: CATraitCollection) -> CAColor {
        textPlaceholderColor(userInterfaceStyle: traitCollection.userInterfaceStyle)
    }

    static func textPlaceholderColor(userInterfaceStyle: CAUserInterfaceStyle) -> CAColor {
        let almostBlack = CAColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        return switch userInterfaceStyle {
        case .dark:
            almostBlack
        case .light, .unspecified:
            almostBlack
        @unknown default:
            almostBlack
        }
    }
}
