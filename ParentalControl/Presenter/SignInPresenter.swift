//
//  SignInPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import Foundation

final class SignInPresenter: BasicPresenter<SignInScreenBasic> {
    func signIn(email: String, password: String) {
        let loadingScreen = screen.displayLoading()
        dataProvider?.signIn(email: email, password: password).then { [weak self] _ in
            self?.screen.onSignInSuccess()
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
