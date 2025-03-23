//
//  ChangePasswordScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 08/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import SnapKit
import SwifterSwift

class ChangePasswordScreenBasic: BasicScreen<ChangePasswordPresenter> {
    unowned var newPasswordField: CATextField!

    private unowned var changePasswordButton: CAButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNewPasswordTextField()
        setupChangePasswordButton()
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
        newPasswordField.setup(
            placeholder: L10n.ChangepasswordScreen.FieldEmail.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        changePasswordButton.setup(
            text: L10n.ChangepasswordScreen.ButtonSavepassword.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
    }

    func setupNewPasswordTextField() {
        newPasswordField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            $0.font = FontsConfiguration.labelFont
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

    private func setupChangePasswordButton() {
        changePasswordButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onChangePasswordTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(newPasswordField.snp.bottom)
                    .offset(3 * GeometryConfiguration.Common.itemSpace)
                make.bottom.lessThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc private func onChangePasswordTap() {
        presenter.changePassword(
            enteredCurrentPassword: "",
            newPassword: newPasswordField.stringValue
        )
    }

    func onPasswordChanged() {
        coordinator?.openSignInScreen()
    }
}

extension ChangePasswordScreenBasic: Screen {}
