//
//  RegisterScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 03/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import SnapKit
import SwifterSwift

class RegisterScreenBasic: BasicScreen<RegisterPresenter> {
    unowned var isParentSwitch: SwitchWithDescription!
    unowned var emailField: CATextField!
    unowned var passwordField: CASecureTextField!
    unowned var passwordAgainField: CASecureTextField!

    private unowned var registerButton: CAButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupIsParentSwitch()
        setupEmailTextField()
        setupPasswordTextField()
        setupPasswordAgainTextField()
        setupRegisterButton()
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
            placeholder: L10n.RegisterScreen.FieldEmail.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        passwordField.setup(
            placeholder: L10n.RegisterScreen.FieldPassword.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        passwordAgainField.setup(
            placeholder: L10n.RegisterScreen.FieldPasswordAgain.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        registerButton.setup(
            text: L10n.RegisterScreen.ButtonRegister.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        isParentSwitch.setupColors(traitCollection: traitCollection)
    }

    func setupIsParentSwitch() {
        isParentSwitch = .init(
            frame: .zero,
            textLeft: L10n.SigninScreen.switchLeft,
            textRight: L10n.SigninScreen.switchRight,
            isOn: !Configuration.isParentApp
        ).then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
                setupItemConstraints(make: make)
            }
        }
    }

    func setupEmailTextField() {
        emailField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            $0.font = FontsConfiguration.labelFont
            $0.keyboardType = .emailAddress
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(isParentSwitch.snp.bottom).inset(-1 * GeometryConfiguration.Common.itemsInset)
                setupTextFieldConstraints(make: make)
                make.bottom.equalTo(view.snp.centerY)
                    .offset(-1 * GeometryConfiguration.Common.centerOffset)
                    .priority(.low)
            }
        }
    }

    func setupPasswordTextField() {
        passwordField = CASecureTextField(inset: GeometryConfiguration.Common.textFieldInset).then {
            view.addSubview($0)
            $0.isSecureTextEntry = true
            $0.snp.makeConstraints { make in
                setupTextFieldConstraints(make: make)
                make.top.equalTo(emailField.snp.bottom)
                    .offset(GeometryConfiguration.Common.itemSpace)
            }
        }
    }

    func setupPasswordAgainTextField() {
        passwordAgainField = CASecureTextField(inset: GeometryConfiguration.Common.textFieldInset).then {
            view.addSubview($0)
            $0.isSecureTextEntry = true
            $0.snp.makeConstraints { make in
                setupTextFieldConstraints(make: make)
                make.top.equalTo(passwordField.snp.bottom)
                    .offset(GeometryConfiguration.Common.itemSpace)
            }
        }
    }

    private func setupRegisterButton() {
        registerButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onRegisterTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(passwordAgainField.snp.bottom)
                    .offset(3 * GeometryConfiguration.Common.itemSpace)
                make.bottom.lessThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc private func onRegisterTap() {
        presenter.register(
            email: emailField.stringValue,
            password: passwordField.stringValue,
            passwordAgain: passwordAgainField.stringValue
        )
    }

    func onRegistrationStarted() {
        display(message: L10n.RegisterScreen.Message.title) { [unowned self] _ in
            coordinator?.openSignInScreen()
        }
    }
}

extension RegisterScreenBasic: Screen {}
