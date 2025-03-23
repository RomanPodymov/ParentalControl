//
//  SignInScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import SnapKit
import SwifterSwift

class SignInScreenBasic: BasicScreen<SignInPresenter> {
    unowned var isParentSwitch: SwitchWithDescription!
    unowned var emailField: CATextField!
    unowned var passwordField: CASecureTextField!

    private unowned var signInButton: CAButton!
    private unowned var restorePasswordButton: CAButton!
    private unowned var registerButton: CAButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupIsParentSwitch()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupResetPasswordButton()
        setupRegisterButton()
        setupColors()
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    private func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)

        view.backgroundColor = viewBackgroundColor
        setupTextFieldsColors()
        setupButtonsColors()
        isParentSwitch.setupColors(traitCollection: traitCollection)
    }

    private func setupTextFieldsColors() {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)
        let labelTextPlaceholderColor = ColorsConfiguration.textPlaceholderColor(traitCollection: traitCollection)
        let labelTextBackgroundColor = ColorsConfiguration.textBackgroundColor(traitCollection: traitCollection)

        emailField.setup(
            placeholder: L10n.SigninScreen.FieldEmail.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        passwordField.setup(
            placeholder: L10n.SigninScreen.FieldPassword.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
    }

    private func setupButtonsColors() {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)
        let labelTextBackgroundColor = ColorsConfiguration.textBackgroundColor(traitCollection: traitCollection)

        signInButton.setup(
            text: L10n.SigninScreen.ButtonSignin.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        restorePasswordButton.setup(
            text: L10n.SigninScreen.ButtonResetpassword.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        registerButton.setup(
            text: L10n.SigninScreen.ButtonRegister.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
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

    private func setupSignInButton() {
        signInButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onSignInTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(passwordField.snp.bottom)
                    .offset(3 * GeometryConfiguration.Common.itemSpace)
            }
        }
    }

    @objc private func onSignInTap() {
        presenter.signIn(email: emailField.stringValue, password: passwordField.stringValue)
    }

    func onSignInSuccess() {
        coordinator?.openMainScreen()
    }

    private func setupResetPasswordButton() {
        restorePasswordButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onResetPasswordTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(signInButton.snp.bottom)
                    .offset(GeometryConfiguration.Common.itemSpace)
            }
        }
    }

    @objc private func onResetPasswordTap() {
        coordinator?.openResetPasswordScreen()
    }

    private func setupRegisterButton() {
        registerButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onRegisterTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(restorePasswordButton.snp.bottom)
                    .offset(GeometryConfiguration.Common.itemSpace)
                make.bottom.lessThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc private func onRegisterTap() {
        coordinator?.openRegisterScreen()
    }
}

extension SignInScreenBasic: Screen {}
