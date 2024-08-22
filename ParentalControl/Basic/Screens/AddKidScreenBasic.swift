//
//  AddKidScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import DifferenceKit
import Foundation
import SnapKit
import SwifterSwift

class AddKidScreenBasic: BasicScreen<AddKidPresenter> {
    private unowned var emailField: CATextField!
    private unowned var addKidButton: CAButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmailField()
        setupAddKidButton()
        setupColors()
    }

    func setupEmailField() {
        emailField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            $0.font = FontsConfiguration.labelFont
            $0.keyboardType = .emailAddress
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

    private func setupAddKidButton() {
        addKidButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onAddKidButtonTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(emailField.snp.bottom)
                    .offset(3 * GeometryConfiguration.Common.itemSpace)
                make.bottom.lessThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc private func onAddKidButtonTap() {
        presenter.addKid(email: emailField.stringValue)
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

        emailField.setup(
            placeholder: L10n.AddKidScreen.FieldEmail.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        addKidButton.setup(
            text: L10n.AddKidScreen.ButtoAdd.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
    }

    func onAdd() {
        coordinator?.openMainScreen()
    }
}

extension AddKidScreenBasic: Screen {}
