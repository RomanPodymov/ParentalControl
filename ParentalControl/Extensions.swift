//
//  Extensions.swift
//  ParentalControl
//
//  Created by Roman Podymov on 14/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import SnapKit
import SwifterSwift

extension BasicScreen {
    func setupTextFieldConstraints(make: ConstraintMaker) {
        make.width.equalTo(GeometryConfiguration.Common.fieldWidth).priority(.high)
        setupItemConstraints(make: make)
    }

    func setupItemConstraints(make: ConstraintMaker) {
        make.leading.greaterThanOrEqualTo(view)
            .inset(GeometryConfiguration.Common.itemsInset)
        make.centerX.equalTo(view)
    }
}

extension Date {
    var asStartFromLabelString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY HH:mm"
        return formatter.string(from: self)
    }

    var asDurationLabelString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

extension CALabel {
    func setup(
        text: String,
        labelTextColor: CAColor
    ) {
        textColor = labelTextColor
        stringValue = text
        font = FontsConfiguration.labelFont
    }

    func setupSub(
        text: String,
        labelTextColor: CAColor
    ) {
        textColor = labelTextColor
        stringValue = text
        font = FontsConfiguration.labelSubFont
    }
}

extension CATextFieldBaseClass {
    func setup(
        placeholder: String,
        labelTextColor: CAColor,
        labelTextPlaceholderColor: CAColor,
        labelTextBackgroundColor: CAColor
    ) {
        font = FontsConfiguration.textFieldFont
        textColor = labelTextColor
        (self as CAView).backgroundColor = labelTextBackgroundColor
        attributedPlaceholder = placeholder
            .withTextColor(labelTextPlaceholderColor)
            .withFont(FontsConfiguration.textFieldFont)
    }
}

extension CAButton {
    func setup(
        text: String,
        labelTextColor: CAColor,
        labelTextBackgroundColor: CAColor
    ) {
        backgroundColor = labelTextBackgroundColor
        let attributedTitleValue = text
            .withTextColor(labelTextColor)
            .withFont(FontsConfiguration.buttonFont)
        #if canImport(UIKit)
            contentEdgeInsets = GeometryConfiguration.Common.buttonContentInsets
            setAttributedTitleForAllStates(attributedTitleValue)
            layer.cornerRadius = GeometryConfiguration.Common.buttonRoundCorder
            layer.masksToBounds = true
        #elseif canImport(AppKit)
            isBordered = false
            attributedTitle = attributedTitleValue
        #endif
    }
}

public extension ConstraintMakerRelatable {
    @discardableResult
    func equalToSuperviewSafe() -> ConstraintMakerEditable {
        if #available(iOS 11.0, tvOS 11.0, macOS 11.0, *) {
            equalToSuperviewSafeAreaLayoutGuide()
        } else {
            equalToSuperview()
        }
    }

    @discardableResult
    func lessThanOrEqualToSuperviewSafe() -> ConstraintMakerEditable {
        if #available(iOS 11.0, tvOS 11.0, macOS 11.0, *) {
            lessThanOrEqualToSuperviewSafeAreaLayoutGuide()
        } else {
            lessThanOrEqualToSuperview()
        }
    }

    @discardableResult
    func greaterThanOrEqualToSuperviewSafe() -> ConstraintMakerEditable {
        if #available(iOS 11.0, tvOS 11.0, macOS 11.0, *) {
            greaterThanOrEqualToSuperviewSafeAreaLayoutGuide()
        } else {
            greaterThanOrEqualToSuperview()
        }
    }
}

extension CAViewController {
    func prepareToUseAsTab(title: String, systemImage: String) {
        #if canImport(UIKit)
            tabBarItem.title = title
            if #available(iOS 13.0, *) {
                tabBarItem.image = CAImage(systemName: systemImage)
            }
        #elseif canImport(AppKit)
            self.title = title
        #endif
    }
}
