//
//  KidTimeSlotsPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import Foundation
import Promises

enum CancelError: Error {
    case cancel
}

final class KidsTimeSlotsPresenter: BasicPresenter<KidsTimeSlotsScreenBasic> {
    private static let pageSize = 20
    var currentOffset = 0
    var currentTotalItem: Int?

    private var loadTimeSlotsCancelHandler: (() -> Void)?

    func loadTimeSlots(kidId: String) {
        let loadingScreen: LoadingScreen? = if currentOffset == 0 {
            screen.displayLoading()
        } else {
            nil
        }
        loadTimeSlotsCancelHandler?()
        let (promise, loadTimeSlotsCancelHandler) = loadTimeSlotsWithCancel(kidId: kidId)
        self.loadTimeSlotsCancelHandler = loadTimeSlotsCancelHandler
        promise.then { [weak self] in
            self?.currentTotalItem = $0.1
            self?.currentOffset += 1
            self?.screen.onTimeSlotsLoaded($0.0)
        }.catch { error in
            if error is CancelError {
            } else {
                display(error: error)
            }
        }.always {
            if let loadingScreen {
                hideLoading(loadingScreen)
            }
        }
    }

    private func loadTimeSlotsWithCancel(kidId: String) -> (Promise<([TimeSlotData], Int)>, cancel: () -> Void) {
        var isCancelled = false

        let promise = Promise<([TimeSlotData], Int)> { [weak self] onSuccess, onError in
            guard !isCancelled else {
                onError(CancelError.cancel)
                return
            }
            self?.dataProvider?.loadTimeSlots(
                kidId: kidId,
                offset: self?.currentOffset ?? 0,
                maxCount: KidsTimeSlotsPresenter.pageSize
            ).then {
                guard !isCancelled else {
                    onError(CancelError.cancel)
                    return
                }
                onSuccess($0)
            }.catch {
                onError($0)
            }
        }

        let cancel = {
            isCancelled = true
        }

        return (promise, cancel)
    }

    func loadTime(kidId: String) {
        let loadingScreen = screen.displayLoading()
        dataProvider?.availableTimeUsingSign(kidId: kidId).then { [weak self] in
            self?.screen.onTimeLoaded(time: $0)
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }

    func deleteTimeSlot(id: String) {
        display(message: L10n.Alert.deleteTimeSlotText, buttons: [.yes, .no]) { [weak self] in
            switch $0 {
            case 0:
                self?.deleteTimeSlotAfertAlert(id: id)
            case 1:
                return
            default:
                return
            }
        }
    }

    private func deleteTimeSlotAfertAlert(id: String) {
        let loadingScreen = screen.displayLoading()
        dataProvider?.deleteTimeSlot(id: id).then { [weak self] in
            self?.screen.onSlotDeleted(id: id)
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
