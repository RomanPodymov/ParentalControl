//
//  SwitchWithDescription.swift
//  ParentalControl
//
//  Created by Roman Podymov on 01/04/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import DifferenceKit
import Foundation

class SwitchWithDescription: CAStackView {
    private unowned var labelLeft: CALabel!
    private unowned var isParentSwitch: CASwitch!
    private unowned var labelRight: CALabel!

    private let textLeft: String
    private let textRight: String

    init(frame frameRect: CARect, textLeft: String, textRight: String, isOn: Bool) {
        self.textLeft = textLeft
        self.textRight = textRight
        super.init(frame: frameRect)

        spacing = CGFloat(GeometryConfiguration.Common.itemsInset)
        labelLeft = CALabel().then {
            addArrangedSubview($0)
        }
        isParentSwitch = CASwitch().then {
            addArrangedSubview($0)
            $0.isOn = isOn
            $0.addTargetForValueChanged(self, action: #selector(Self.onSwitch))
        }
        labelRight = CALabel().then {
            addArrangedSubview($0)
        }
    }

    @objc private func onSwitch() {
        Configuration.isParentApp = !isParentSwitch.isOn
    }

    #if os(macOS)
        required init?(coder _: NSCoder) {
            nil
        }
    #else
        @available(*, unavailable)
        required init(coder _: NSCoder) {
            fatalError()
        }
    #endif

    func setupColors(traitCollection: CATraitCollection) {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)

        labelLeft.setup(
            text: textLeft,
            labelTextColor: labelTextColor
        )
        labelRight.setup(
            text: textRight,
            labelTextColor: labelTextColor
        )
    }
}
