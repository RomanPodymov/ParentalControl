//
//  SignInScreen.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

final class SignInScreen: SignInScreenBasic {
    override func setupEmailTextField() {
        super.setupEmailTextField()
        emailField.keyboardType = .emailAddress
    }

    override func setupPasswordTextField() {
        super.setupPasswordTextField()
        passwordField.isSecureTextEntry = true
    }
}
