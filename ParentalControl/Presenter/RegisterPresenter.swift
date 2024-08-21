//
//  RegisterPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 03/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import Foundation
import Promises

enum RegisterPresenterError: Error {
    case passwordsAreDifferent
}

extension RegisterPresenterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .passwordsAreDifferent:
            // TODO:
            "" // L10n.RegisterScreen.Message
        }
    }
}

final class RegisterPresenter: BasicPresenter<RegisterScreenBasic> {
    func register(email: String, password: String, passwordAgain: String) {
        let isParent = if Configuration.isParentApp {
            true
        } else {
            false
        }
        let loadingScreen = screen.displayLoading()
        Promise<Void> {
            guard password == passwordAgain else {
                throw RegisterPresenterError.passwordsAreDifferent
            }
            return ()
        }.then { [weak self] in
            self?.dataProvider?.register(email: email, password: password, isParent: isParent)
        }.then { [weak self] _ in
            self?.screen.onRegistrationStarted()
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
