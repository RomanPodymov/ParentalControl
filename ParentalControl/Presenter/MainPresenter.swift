//
//  MainPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 06/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

final class MainPresenter: BasicPresenter<MainScreenBasic> {
    func loadCurrentUserId() {
        let loadingScreen = screen.displayLoading()
        dataProvider?.currentUser.then { [weak self] in
            Configuration.isParentApp = $0?.isParent ?? false
            self?.screen.onCurrentUserIdLoaded(id: $0?.id)
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
