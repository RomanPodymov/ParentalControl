//
//  TimeSlotsCellRootViewBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 29/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation

enum Action {
    case delete(id: String)
}

class TimeSlotsCellRootViewBasic: CAScreenItem {
    unowned var infoLabel: CATextLabel!
    unowned var startDateLabel: CATextLabel!
    unowned var deleteSlotButton: CAButton!
    weak var cell: CAListViewCell<TimeSlotsCellRootView>?

    var data: TimeSlotData? {
        didSet {
            onDataSet()
        }
    }

    func onDataSet() {
        setupColors()
    }

    private var infoLabelValue: String {
        guard let data else {
            return ""
        }
        return [
            data.isAdding ? "+" : "-",
            String(data.activityDuration) + "m",
            data.activityDescription,
        ].joined(separator: " ")
    }

    private var startDateLabelValue: String {
        guard let data else {
            return ""
        }
        return [
            L10n.KidsTimeSlotsScreen.wasAddedMessage + " " + data.created.asStartFromLabelString,
            data.startDate.map { L10n.KidsTimeSlotsScreen.startDateMessage + " " + $0.asStartFromLabelString },
        ].compactMap { $0 }.joined(separator: "\n")
    }

    override init(frame: CARect) {
        super.init(frame: frame)

        setupInfoLabel()
        setupStartDateLabel()
        setupDeleteSlotButton()
    }

    private func setupInfoLabel() {
        infoLabel = .init().then {
            #if canImport(UIKit)
                $0.numberOfLines = 1
            #endif
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.top.equalToSuperview()
            }
        }
    }

    private func setupStartDateLabel() {
        startDateLabel = .init().then {
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.bottom.equalToSuperview()
                make.trailing.equalTo(infoLabel)
                make.top.equalTo(infoLabel.snp.bottom).inset(-1 * GeometryConfiguration.Common.itemSpaceSmall)
            }
        }
    }

    private func setupDeleteSlotButton() {
        deleteSlotButton = CAButton().then {
            addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onDeleteSlotTap))
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.snp.makeConstraints { make in
                make.trailing.centerY.equalToSuperview()
                make.leading.equalTo(infoLabel.snp.trailing).inset(-1 * GeometryConfiguration.Common.itemSpaceSmall)
            }
            $0.setSystemImage(
                "xmark.circle.fill",
                tintColor: .red,
                newSize: .init(
                    width: GeometryConfiguration.Common.smallButtonSize,
                    height: GeometryConfiguration.Common.smallButtonSize
                )
            )
        }
    }

    @objc private func onDeleteSlotTap() {
        cell?.delegate?.onAction(data: Action.delete(id: data?.objectId ?? ""))
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    private func setupColors() {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)

        infoLabel.setup(
            text: infoLabelValue,
            labelTextColor: labelTextColor
        )
        startDateLabel.setupSub(
            text: startDateLabelValue,
            labelTextColor: labelTextColor
        )
    }

    required init?(coder _: NSCoder) {
        nil
    }
}
