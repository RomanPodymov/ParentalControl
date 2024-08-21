//
//  KidsScreen.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import ParentalControlCommon
import SwifterSwift

final class KidsScreen: KidsScreenBasic {
    override func fff() {
        let language = Locale.current.languageCode
        let greet = Greeting().screenLabel(language: language ?? "")
        kidsTitleLabel.stringValue = greet
    }

    override func setupKidsListView() {
        super.setupKidsListView()

        kidsListView.layerCornerRadius = 10
        kidsListView.layerBorderWidth = 2
    }

    override func setupColors() {
        super.setupColors()
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)

        kidsListView.layerBorderColor = labelTextColor
    }
}
