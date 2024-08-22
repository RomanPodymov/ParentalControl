//
//  DurationScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/05/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import DifferenceKit
import Foundation
import SnapKit
import SwifterSwift

class DurationScreenBasic: BasicScreen<DurationPresenter> {
    private unowned var hoursField: CATextField!
    private unowned var minutesField: CATextField!
    private unowned var saveButton: CAButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHoursField()
        setupMinutesField()
        setupSaveButton()
        setupColors()
    }

    func setupHoursField() {
        hoursField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            $0.font = FontsConfiguration.textFieldFont
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
                setupTextFieldConstraints(make: make)
                make.bottom.equalTo(view.snp.centerY)
                    .offset(-1 * GeometryConfiguration.Common.centerOffset)
                    .priority(.low)
            }
        }
    }

    func setupMinutesField() {
        minutesField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            $0.font = FontsConfiguration.textFieldFont
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                setupTextFieldConstraints(make: make)
                make.bottom.equalTo(view.snp.centerY)
                    .offset(GeometryConfiguration.Common.centerOffset)
                    .priority(.low)
            }
        }
    }

    private func setupSaveButton() {
        saveButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onSaveButtonTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(minutesField.snp.bottom)
                    .offset(3 * GeometryConfiguration.Common.itemSpace)
                make.bottom.lessThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc private func onSaveButtonTap() {
        presenter.saveDuration(hours: hoursField.stringValue, minutes: minutesField.stringValue)
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)
        let labelTextPlaceholderColor = ColorsConfiguration.textPlaceholderColor(traitCollection: traitCollection)
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)
        let labelTextBackgroundColor = ColorsConfiguration.textBackgroundColor(traitCollection: traitCollection)

        view.backgroundColor = viewBackgroundColor

        hoursField.setup(
            placeholder: L10n.AddKidScreen.FieldEmail.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        minutesField.setup(
            placeholder: L10n.AddKidScreen.FieldEmail.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        saveButton.setup(
            text: L10n.AddKidScreen.ButtoAdd.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
    }

    func onDurationSaved(hours: Int, minutes: Int) {
        coordinator?.openAddKid(hours: nil, minutes: nil)
    }
}

extension DurationScreenBasic: Screen {}
