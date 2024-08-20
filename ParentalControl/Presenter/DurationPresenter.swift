//
//  DurationPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 15/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import Foundation
import Promises

enum DurationPresenterError: Error {
    case invalidHours
    case invalidMinutes
}

final class DurationPresenter: BasicPresenter<DurationScreenBasic> {
    required init(screen: DurationScreenBasic, coordinator: Coordinator?) {
        super.init(screen: screen, coordinator: coordinator)
    }

    func saveDuration(hours: String?, minutes: String?) {
        let loadingScreen = screen.displayLoading()
        Promise<(Int, Int)>(on: .promises) { onSuccess, onError in
            let hoursInt = hours.flatMap { Int($0) }
            let minutesInt = hours.flatMap { Int($0) }

            if let hoursInt, let minutesInt {
                onSuccess((hoursInt, minutesInt))
            } else if hoursInt == nil {
                onError(DurationPresenterError.invalidHours)
            } else if minutesInt == nil {
                onError(DurationPresenterError.invalidMinutes)
            }
        }.then { [weak self] _ in
            self?.screen.onDurationSaved(hours: 0, minutes: 0)
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
