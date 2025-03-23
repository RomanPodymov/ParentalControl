//
//  KidsCellBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 09/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit

class KidsCellBasic: CAListViewCell<KidsCellRootView> {
    override var representedObject: Any? {
        didSet {
            rootView.data = representedObject as? KidData
        }
    }

    override open func createRootView(frame: CARect) -> KidsCellRootView {
        let result = KidsCellRootView(frame: frame)
        result.cell = self
        return result
    }
}
