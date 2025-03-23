//
//  GeometryConfiguration.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif
import CommonAppleKit
import Foundation

enum GeometryConfiguration {
    enum Common {
        static let centerOffset = 100
        static let buttonContentInsets = CAEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let buttonRoundCorder: CGFloat = 10
        static let fieldWidth = 200
        static let textFieldInset: CGFloat = 10
        static let itemSpace = 15
        static let itemSpaceSmall = 5
        static let itemsInset = 30
        static let buttonSize = 50
        static let smallButtonSize = buttonSize / 2
        static let listWidth: CGFloat = {
            #if canImport(UIKit)
                min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - 100
            #else
                return 400
            #endif
        }()

        static let listItemHeight = 120.0
        static let descriptionTextFieldHeight = 300
        static let listFooterWidth = 200
        static let listFooterHeight = 100
        static let imageSize = 200
        static let imageSizeSmall = 30
    }
}
