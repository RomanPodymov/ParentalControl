//
//  KidsCellRootViewBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import DifferenceKit
import Foundation
import Kingfisher

struct KidData {
    let objectId: String
    let email: String
    let avatar: String?
}

class KidsCellRootViewBasic: CAScreenItem {
    unowned var infoLabel: CATextLabel!
    unowned var avatarImageView: CAImageView!
    weak var cell: KidsCellBasic?

    var data: KidData? {
        didSet {
            guard let data else {
                infoLabel.stringValue = ""
                return
            }
            infoLabel.stringValue = data.email
            if let avatar = data.avatar {
                avatarImageView.kf.setImage(with: URL(string: avatar), options: [.forceRefresh])
            }
        }
    }

    override init(frame: CARect) {
        super.init(frame: frame)

        setupInfoLabel()
        setupAvatarImageView()
        setupColors()
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

    func setupInfoLabel() {
        infoLabel = .init().then {
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.top.bottom.equalToSuperview()
            }
        }
    }

    private func setupAvatarImageView() {
        avatarImageView = .init().then {
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.size.equalTo(GeometryConfiguration.Common.imageSizeSmall)
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview()
                make.leading.equalTo(infoLabel.snp.trailing)
            }
        }
    }

    required init?(coder _: NSCoder) {
        nil
    }

    #if canImport(AppKit)
        override func didTap() {
            let delegate = cell?.delegate
            delegate?.onAction(data: data)
        }
    #endif
}

extension KidData: Differentiable {
    func isContentEqual(to source: KidData) -> Bool {
        differenceIdentifier == source.differenceIdentifier
    }

    public var differenceIdentifier: String {
        objectId
    }
}
