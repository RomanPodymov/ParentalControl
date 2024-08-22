//
//  KidsTimeSlotsScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import DifferenceKit
import Foundation
import OrderedCollections
import SnapKit
import SwifterSwift

class KidsTimeSlotsScreenBasic: BasicScreen<KidsTimeSlotsPresenter> {
    private unowned var timeLabel: CATextLabel!
    private unowned var addForBadButton: CAButton!
    private unowned var addForGoodButton: CAButton!
    private unowned var timeSlotsListView: TimeSlotsListView!

    private let kidId: String
    private var time: Int = 0

    required init(
        kidId: String,
        coordinator: Coordinator?,
        withCloseButton: Bool,
        withBackButton: Bool,
        customNavigationController: NavigationController?
    ) {
        self.kidId = kidId
        super.init(
            coordinator: coordinator,
            withCloseButton: withCloseButton,
            withBackButton: withBackButton,
            customNavigationController: customNavigationController
        )
    }

    required init?(coder _: NSCoder) {
        nil
    }

    required init(
        coordinator: Coordinator?,
        withCloseButton: Bool,
        withBackButton: Bool,
        customNavigationController: NavigationController?
    ) {
        kidId = ""
        super.init(
            coordinator: coordinator,
            withCloseButton: withCloseButton,
            withBackButton: withBackButton,
            customNavigationController: customNavigationController
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTimeLabel()
        setupAddForBadButton()
        if Configuration.isParentApp {
            setupAddForGoodButton()
        }
        setupTimeSlotsListView()
        setupColors()
    }

    override func willAppear() {
        super.willAppear()

        reloadData()
    }

    private func reloadData() {
        presenter.currentOffset = 0
        presenter.currentTotalItem = nil
        timeSlotsListView.content = .init()
        timeSlotsListView.footerReferenceSize = .init(
            width: GeometryConfiguration.Common.listFooterWidth,
            height: GeometryConfiguration.Common.listFooterHeight
        )

        presenter.loadTimeSlots(kidId: kidId)
        presenter.loadTime(kidId: kidId)
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)

        view.backgroundColor = viewBackgroundColor
        setupLabelsColors()
    }

    private func setupLabelsColors() {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)

        timeLabel.setup(
            text: String(time) + L10n.KidsTimeSlotsScreen.message,
            labelTextColor: labelTextColor
        )
    }

    func setupTimeLabel() {
        timeLabel = .init().then {
            view.addSubview($0)
            $0.alignment = .center
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperviewSafe()
                make.top.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemSpace)
            }
        }
    }

    private func setupAddForBadButton() {
        addForBadButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onAddForBadButtonTap))
            $0.snp.makeConstraints { make in
                make.size.equalTo(GeometryConfiguration.Common.buttonSize)
                make.leading.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset)
                make.top.equalTo(timeLabel.snp.bottom)
            }
            $0.setSystemImage(
                "minus.square",
                tintColor: .red,
                newSize: .init(
                    width: GeometryConfiguration.Common.buttonSize,
                    height: GeometryConfiguration.Common.buttonSize
                )
            )
        }
    }

    @objc private func onAddForBadButtonTap() {
        coordinator?.openAddTimeSlots(isAdding: false, kidId: kidId)
    }

    private func setupAddForGoodButton() {
        addForGoodButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onAddForGoodButtonTap))
            $0.snp.makeConstraints { make in
                make.size.equalTo(GeometryConfiguration.Common.buttonSize)
                make.trailing.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset)
                make.centerY.equalTo(addForBadButton)
            }
            $0.setSystemImage(
                "plus.square",
                tintColor: .green,
                newSize: .init(
                    width: GeometryConfiguration.Common.buttonSize,
                    height: GeometryConfiguration.Common.buttonSize
                )
            )
        }
    }

    @objc private func onAddForGoodButtonTap() {
        coordinator?.openAddTimeSlots(isAdding: true, kidId: kidId)
    }

    private func setupTimeSlotsListView() {
        timeSlotsListView = .init(
            frame: .zero,
            itemSize: .init(
                width: GeometryConfiguration.Common.listWidth,
                height: GeometryConfiguration.Common.listItemHeight
            ),
            footerReferenceSize: .init(
                width: GeometryConfiguration.Common.listFooterWidth,
                height: GeometryConfiguration.Common.listFooterHeight
            ),
            cellDelegate: self
        ).then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.bottom.trailing.equalToSuperviewSafe()
                make.top.equalTo(addForBadButton.snp.bottom)
            }
        }
    }

    func onTimeSlotsLoaded(_ timeSlots: [TimeSlotData]) {
        timeSlotsListView.content += timeSlots
        if timeSlotsListView.content.count >= (presenter.currentTotalItem ?? 0) {
            timeSlotsListView.footerReferenceSize = .zero
        } else {
            timeSlotsListView.footerReferenceSize = .init(
                width: GeometryConfiguration.Common.listFooterWidth,
                height: GeometryConfiguration.Common.listFooterHeight
            )
        }
    }

    func onTimeLoaded(time: Int) {
        self.time = time
        setupLabelsColors()
    }

    func onSlotDeleted(id _: String) {
        reloadData()
    }
}

extension KidsTimeSlotsScreenBasic: CAListViewCellDelegate {
    #if canImport(UIKit)
        func onCellTap(data _: Any?) {}
    #endif

    func onAction(data: Any?) {
        if let action = data as? Action {
            switch action {
            case let .delete(id):
                presenter.deleteTimeSlot(id: id)
            }
        }
    }

    func onHeaderWillBeDisplayed() {}

    func onFooterWillBeDisplayed() {
        presenter.loadTimeSlots(kidId: kidId)
    }
}

extension KidsTimeSlotsScreenBasic: Screen {}
