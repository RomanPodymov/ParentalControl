//
//  KidsScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import DifferenceKit
import Foundation
import SnapKit
import SwifterSwift

class KidsScreenBasic: BasicScreen<KidsPresenter> {
    unowned var kidsTitleLabel: CATextLabel!
    private unowned var addKidButton: CAButton!
    unowned var kidsListView: KidsListView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupKidsTitleLabel()
        setupAddKidButton()
        setupKidsListView()
        setupColors()
        fff()
    }

    func fff() {}

    override func willAppear() {
        super.willAppear()

        presenter.loadKids()
    }

    private func setupKidsTitleLabel() {
        kidsTitleLabel = .init().then {
            view.addSubview($0)
            $0.alignment = .center
            $0.snp.makeConstraints { make in
                make.leading.top.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    private func setupAddKidButton() {
        addKidButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onAddKidButtonTap))
            $0.snp.makeConstraints { make in
                make.size.equalTo(GeometryConfiguration.Common.buttonSize)
                make.trailing.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset)
                make.centerY.equalTo(kidsTitleLabel)
                make.leading.greaterThanOrEqualTo(kidsTitleLabel.snp.trailing)
            }
        }
    }

    @objc private func onAddKidButtonTap() {
        coordinator?.openAddKid(hours: nil, minutes: nil)
    }

    func setupKidsListView() {
        kidsListView = .init(
            frame: .zero,
            itemSize: .init(
                width: GeometryConfiguration.Common.listWidth,
                height: GeometryConfiguration.Common.listItemHeight
            ),
            cellDelegate: self
        ).then {
            view.addSubview($0)
            $0.emptyView = KidsScreenEmptyView()
            $0.snp.makeConstraints { make in
                make.top.equalTo(kidsTitleLabel.snp.bottom).offset(GeometryConfiguration.Common.itemsInset)
                make.leading.equalToSuperviewSafe().offset(GeometryConfiguration.Common.itemsInset)
                make.bottom.equalToSuperviewSafe().offset(-1 * GeometryConfiguration.Common.itemsInset)
                make.trailing.equalToSuperviewSafe().offset(-1 * GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)

        view.backgroundColor = viewBackgroundColor

        kidsTitleLabel.setup(
            text: L10n.KidsScreen.message,
            labelTextColor: labelTextColor
        )
        addKidButton.setSystemImage(
            "plus.square",
            tintColor: labelTextColor,
            newSize: .init(
                width: GeometryConfiguration.Common.buttonSize,
                height: GeometryConfiguration.Common.buttonSize
            )
        )
    }

    func onKidsLoaded(_ kids: [KidData]) {
        kidsListView.content = kids
    }
}

extension KidsScreenBasic: CAListViewCellDelegate {
    #if canImport(UIKit)
        func onCellTap(data: Any?) {
            coordinator?.openKidTimeSlots(kidId: (data as? KidData)?.objectId ?? "")
        }
    #endif

    func onAction(data: Any?) {
        coordinator?.openKidTimeSlots(kidId: (data as? KidData)?.objectId ?? "")
    }

    func onHeaderWillBeDisplayed() {}

    func onFooterWillBeDisplayed() {
        presenter.loadKids()
    }
}

extension KidsScreenBasic: Screen {}
