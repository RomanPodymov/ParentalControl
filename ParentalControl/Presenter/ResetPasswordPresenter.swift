//
//  ResetPasswordPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 03/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import Foundation

final class ResetPasswordPresenter: BasicPresenter<ResetPasswordScreenBasic> {
    func resetPassword(email: String) {
        let loadingScreen = screen.displayLoading()
        dataProvider?.resetPassword(email: email).then {}.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
