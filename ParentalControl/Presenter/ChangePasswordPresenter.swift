//
//  ChangePasswordPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 03/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import Foundation

final class ChangePasswordPresenter: BasicPresenter<ChangePasswordScreenBasic> {
    func changePassword(enteredCurrentPassword _: String, newPassword: String) {
        let loadingScreen = screen.displayLoading()

        dataProvider?.changePassword(newPassword: newPassword).then { [weak self] in
            self?.dataProvider?.logout() ?? .init()
        }.then { [weak self] in
            self?.screen.onPasswordChanged()
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
