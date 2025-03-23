//
//  KidsPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import Foundation

final class KidsPresenter: BasicPresenter<KidsScreenBasic> {
    func loadKids() {
        let loadingScreen = screen.displayLoading()
        dataProvider?.loadKids().then { [weak self] in
            self?.screen.onKidsLoaded($0)
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
