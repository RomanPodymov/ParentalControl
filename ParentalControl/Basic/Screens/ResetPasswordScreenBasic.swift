//
//  ResetPasswordScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 03/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import SnapKit
import SwifterSwift

class ResetPasswordScreenBasic: BasicScreen<ResetPasswordPresenter> {
    unowned var emailField: CATextField!

    private unowned var resetPasswordButton: CAButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmailTextField()
        setupResetPasswordButton()
        setupColors()
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    private func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)
        let labelTextPlaceholderColor = ColorsConfiguration.textPlaceholderColor(traitCollection: traitCollection)
        let labelTextBackgroundColor = ColorsConfiguration.textBackgroundColor(traitCollection: traitCollection)

        view.backgroundColor = viewBackgroundColor
        emailField.setup(
            placeholder: L10n.ResetpasswordScreen.FieldEmail.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        resetPasswordButton.setup(
            text: L10n.ResetpasswordScreen.ButtonResetpassword.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
    }

    func setupEmailTextField() {
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

    private func setupResetPasswordButton() {
        resetPasswordButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onRegisterTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(emailField.snp.bottom)
                    .offset(3 * GeometryConfiguration.Common.itemSpace)
                make.bottom.lessThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc private func onRegisterTap() {
        presenter.resetPassword(email: emailField.stringValue)
    }
}

extension ResetPasswordScreenBasic: Screen {}
