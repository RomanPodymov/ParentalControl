//
//  AddTimeSlotPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 15/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import Foundation

final class AddTimeSlotPresenter: BasicPresenter<AddTimeSlotScreenBasic> {
    required init(screen: AddTimeSlotScreenBasic, coordinator: Coordinator?) {
        super.init(screen: screen, coordinator: coordinator)
    }

    func saveTimeSlot(minutes: Int, startDate: Date?, text: String, isAdding: Bool, kidId: String) {
        let loadingScreen = screen.displayLoading()
        dataProvider?.addTimeSlot(timeSlot:
            .init(
                objectId: "",
                startDate: startDate,
                activityDuration: minutes,
                activityDescription: text,
                isAdding: isAdding,
                ownerId: "",
                kidId: kidId,
                created: Date()
            )
        ).then { [weak self] _ in
            self?.screen.onSaveTimeSlotSuccess()
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}
