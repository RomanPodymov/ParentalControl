//
//  KidsCellRootView.swift
//  ParentalControl
//
//  Created by Roman Podymov on 09/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

final class KidsCellRootView: KidsCellRootViewBasic {
    override func setupInfoLabel() {
        super.setupInfoLabel()

        infoLabel.isEditable = false
    }
}
