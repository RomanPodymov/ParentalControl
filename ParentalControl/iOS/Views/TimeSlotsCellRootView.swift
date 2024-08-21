//
//  TimeSlotsCellRootView.swift
//  ParentalControl
//
//  Created by Roman Podymov on 29/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import SwiftSDK

final class TimeSlotsCellRootView: TimeSlotsCellRootViewBasic {
    override func onDataSet() {
        super.onDataSet()

        if data?.ownerId == Backendless.shared.userService.currentUser?.objectId {
            infoLabel.textAlignment = .right
            startDateLabel.textAlignment = .right
        } else {
            infoLabel.textAlignment = .left
            startDateLabel.textAlignment = .left
        }
    }
}
