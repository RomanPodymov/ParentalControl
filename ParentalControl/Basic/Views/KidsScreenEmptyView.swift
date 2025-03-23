//
//  KidsScreenEmptyView.swift
//  ParentalControl
//
//  Created by Roman Podymov on 17/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation

class KidsScreenEmptyView: CAScreenItem {
    private unowned var infoLabel: CALabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        infoLabel = CALabel().then {
            addSubview($0)
            $0.alignment = .center
            $0.stringValue = L10n.KidsScreen.emptyMessage
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        setupColors()
    }

    required init?(coder _: NSCoder) {
        nil
    }

    private func setupColors() {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)

        infoLabel.setup(
            text: infoLabel.stringValue,
            labelTextColor: labelTextColor
        )
    }

    override func didChangeTraitCollection() {
        super.didChangeTraitCollection()
        setupColors()
    }
}
