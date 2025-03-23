//
//  AddTimeSlotScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 15/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import SnapKit
import SwiftyAttributes

class AddTimeSlotScreenBasic: BasicScreen<AddTimeSlotPresenter> {
    private unowned var descriptionLabel: CATextLabel!
    private unowned var startDateField: CATextField!
    private unowned var durationField: CATextField!
    private unowned var descriptionField: CATextField!
    private unowned var saveTimeSlotButton: CAButton!

    private let isAdding: Bool
    private let kidId: String

    private var currentDate: Date?
    private var currentDurationDate: Date?

    init(
        isAdding: Bool,
        kidId: String,
        coordinator: Coordinator,
        withCloseButton: Bool,
        withBackButton: Bool,
        customNavigationController: NavigationController?
    ) {
        self.isAdding = isAdding
        self.kidId = kidId
        super.init(
            coordinator: coordinator,
            withCloseButton: withCloseButton,
            withBackButton: withBackButton,
            customNavigationController: customNavigationController
        )
    }

    required init(
        coordinator: Coordinator?,
        withCloseButton: Bool,
        withBackButton: Bool,
        customNavigationController: NavigationController?
    ) {
        isAdding = false
        kidId = ""
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGreetingLabel()
        setupStartDateField()
        setupDurationField()
        setupDescriptionField()
        setupSaveTimeSlotButton()
        setupColors()
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    private func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)
        let labelTextPlaceholderColor = ColorsConfiguration.textPlaceholderColor(traitCollection: traitCollection)
        let labelTextBackgroundColor = ColorsConfiguration.textBackgroundColor(traitCollection: traitCollection)

        view.backgroundColor = viewBackgroundColor

        descriptionLabel.setup(
            text: isAdding ? L10n.AddtimeslotScreen.labelAdding : L10n.AddtimeslotScreen.labelRemoving,
            labelTextColor: labelTextColor
        )
        startDateField.setup(
            placeholder: L10n.AddtimeslotScreen.FieldFrom.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        durationField.setup(
            placeholder: L10n.AddtimeslotScreen.FieldDuration.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        descriptionField.setup(
            placeholder: L10n.AddtimeslotScreen.FieldDescription.placeholder,
            labelTextColor: labelTextColor,
            labelTextPlaceholderColor: labelTextPlaceholderColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        saveTimeSlotButton.setup(
            text: L10n.AddtimeslotScreen.ButtonSave.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
    }

    private func setupGreetingLabel() {
        descriptionLabel = .init().then {
            view.addSubview($0)
            $0.alignment = .center
            $0.snp.makeConstraints { make in
                make.top.equalToSuperviewSafe().offset(GeometryConfiguration.Common.itemsInset)
                make.leading.trailing.equalToSuperviewSafe()
            }
        }
    }

    func setupStartDateField() {
        startDateField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            view.addSubview($0)
            let datePicker = CADatePicker()
            #if canImport(UIKit)
                datePicker.datePickerMode = .dateAndTime
                datePicker.addTarget(self, action: #selector(Self.onStartDateChanged), for: .valueChanged)
                $0.inputView = datePicker
            #endif
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperviewSafe().offset(GeometryConfiguration.Common.itemsInset)
                make.top.equalTo(descriptionLabel.snp.bottom).inset(-1 * GeometryConfiguration.Common.itemSpace)
                make.trailing.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset)
            }
            if Configuration.isParentApp {
                $0.isHidden = true
            }
        }
    }

    @objc func onStartDateTap() {}

    @objc private func onStartDateChanged(_ sender: CADatePicker) {
        #if canImport(UIKit)
            currentDate = sender.date
        #endif
        startDateField.stringValue = L10n.AddtimeslotScreen.FieldFrom.placeholder +
            (currentDate ?? .init()).asStartFromLabelString
    }

    func setupDurationField() {
        durationField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            view.addSubview($0)
            let datePicker = CADatePicker()
            #if canImport(UIKit)
                datePicker.datePickerMode = .countDownTimer
                datePicker.addTarget(self, action: #selector(Self.onDurationChanged), for: .valueChanged)
                $0.inputView = datePicker
            #endif
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperviewSafe().offset(GeometryConfiguration.Common.itemsInset)
                make.top.equalTo(startDateField.snp.bottom)
                    .inset(-1 * GeometryConfiguration.Common.itemSpace)
                make.trailing.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc func onDurationTap() {
        coordinator?.openDurationScreen()
    }

    func setupDescriptionField() {
        descriptionField = .init(inset: GeometryConfiguration.Common.textFieldInset).then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperviewSafe().offset(GeometryConfiguration.Common.itemsInset)
                make.top.equalTo(durationField.snp.bottom).inset(-1 * GeometryConfiguration.Common.itemSpace)
                make.trailing.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset)
                make.height.equalTo(GeometryConfiguration.Common.descriptionTextFieldHeight).priority(.high)
            }
        }
    }

    func setupSaveTimeSlotButton() {
        saveTimeSlotButton = .init().then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerX.equalTo(view)
                make.bottom.equalToSuperviewSafe().inset(GeometryConfiguration.Common.itemsInset * 2)
                make.top.equalTo(descriptionField.snp.bottom).inset(-1 * GeometryConfiguration.Common.itemSpace)
            }
            $0.setTitle(L10n.AddtimeslotScreen.ButtonSave.title)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onSaveTimeSlotTap))
        }
    }

    @objc private func onDurationChanged(_ sender: CADatePicker) {
        #if canImport(UIKit)
            currentDurationDate = sender.date
        #endif
        durationField.stringValue = L10n.AddtimeslotScreen.FieldDuration.placeholder +
            (currentDurationDate ?? .init()).asDurationLabelString
    }

    @objc func onSaveTimeSlotTap() {
        presenter.saveTimeSlot(
            minutes: dateToDuration(date: currentDurationDate ?? .init()),
            startDate: currentDate,
            text: descriptionField.stringValue,
            isAdding: isAdding,
            kidId: kidId
        )
    }

    private func dateToDuration(date: Date) -> Int {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)

        return (dateComponents.hour ?? 0) * 60 + (dateComponents.minute ?? 0)
    }

    func onSaveTimeSlotSuccess() {
        coordinator?.openKidTimeSlots(kidId: kidId)
    }
}

extension AddTimeSlotScreenBasic: Screen {}
