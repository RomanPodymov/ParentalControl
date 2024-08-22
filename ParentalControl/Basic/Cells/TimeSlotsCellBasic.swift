//
//  TimeSlotsCellBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 14/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation

class TimeSlotsCellBasic: CAListViewCell<TimeSlotsCellRootView> {
    override var representedObject: Any? {
        didSet {
            rootView.data = representedObject as? TimeSlotData
        }
    }

    override open func createRootView(frame: CARect) -> TimeSlotsCellRootView {
        let result = TimeSlotsCellRootView(frame: frame)
        result.cell = self
        return result
    }
}
