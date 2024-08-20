//
//  AddKidPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import Foundation

final class AddKidPresenter: BasicPresenter<AddKidScreenBasic> {
    func addKid(email: String) {
        let loadingScreen = screen.displayLoading()
        dataProvider?.addKid(email: email).then { [weak self] _ in
            self?.screen.onAdd()
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
