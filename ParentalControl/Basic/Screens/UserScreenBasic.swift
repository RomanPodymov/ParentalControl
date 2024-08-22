//
//  UserScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 07/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import Kingfisher
import SnapKit
import SwifterSwift
import SwiftSDK

class UserScreenBasic: BasicScreen<UserPresenter> {
    unowned var avatarImageView: CAImageView!
    unowned var greetingLabel: CATextLabel!

    private unowned var changePhotoButton: CAButton!
    private unowned var changePasswordButton: CAButton!
    private unowned var logoutButton: CAButton!
    private unowned var deleteAccountButton: CAButton!

    private var userInfo: UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAvatarImageView()
        setupGreetingLabel()
        #if canImport(UIKit)
            setupChangePhotoButton()
        #endif
        setupChangePasswordButton()
        setupLogoutButton()
        setupDeleteAccountButton()
        setupColors()
        presenter.loadUserInfo()
    }

    func onUserInfoSuccess(userInfo: UserInfo?) {
        self.userInfo = userInfo
        avatarImageView.kf.setImage(with: userInfo?.avatar, options: [.forceRefresh])
        setupLabelsColors()
    }

    override open func didChangeTraitCollection() {
        setupColors()
    }

    private func setupLabelsColors() {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)

        greetingLabel.setup(
            text: L10n.UserScreen.greeting + (userInfo?.email ?? ""),
            labelTextColor: labelTextColor
        )
    }

    private func setupButtonsColors() {
        let labelTextColor = ColorsConfiguration.textColor(traitCollection: traitCollection)
        let labelTextBackgroundColor = ColorsConfiguration.textBackgroundColor(traitCollection: traitCollection)

        #if canImport(UIKit)
            changePhotoButton.setup(
                text: L10n.UserScreen.ButtonChangephoto.title,
                labelTextColor: labelTextColor,
                labelTextBackgroundColor: labelTextBackgroundColor
            )
        #endif
        changePasswordButton.setup(
            text: L10n.UserScreen.ButtonChangepassword.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        logoutButton.setup(
            text: L10n.UserScreen.ButtonLogout.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
        deleteAccountButton.setup(
            text: L10n.UserScreen.ButtonDeleteaccount.title,
            labelTextColor: labelTextColor,
            labelTextBackgroundColor: labelTextBackgroundColor
        )
    }

    private func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)

        view.backgroundColor = viewBackgroundColor

        setupLabelsColors()
        setupButtonsColors()
    }

    private func setupAvatarImageView() {
        avatarImageView = .init().then {
            view.addSubview($0)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            $0.snp.makeConstraints { make in
                make.width.equalTo(GeometryConfiguration.Common.imageSize)
                make.height.equalTo(GeometryConfiguration.Common.imageSize).priority(.low)
                make.centerX.equalToSuperview()
                make.top.greaterThanOrEqualToSuperviewSafe().inset(-GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    func setupGreetingLabel() {
        greetingLabel = .init().then {
            view.addSubview($0)
            $0.alignment = .center
            $0.snp.makeConstraints { make in
                make.top.equalTo(avatarImageView.snp.bottom).offset(GeometryConfiguration.Common.itemSpace)
                make.leading.trailing.equalToSuperviewSafe()
                make.bottom.equalTo(view.snp.centerY)
                    .offset(-1 * GeometryConfiguration.Common.centerOffset)
                    .priority(.low)
            }
        }
    }

    private func setupChangePhotoButton() {
        changePhotoButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onChangePhotoTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(greetingLabel.snp.bottom)
                    .offset(3 * GeometryConfiguration.Common.itemSpace)
            }
        }
    }

    @objc private func onChangePhotoTap() {
        presenter.selectPhoto()
    }

    func onPhotoSelected(image: CAImage) {
        #if canImport(UIKit)
            if let data = image.jpegData(compressionQuality: 1) {
                presenter.uploadPhoto(data: data)
            }
        #endif
    }

    func onPhotoSent(url: String) {
        avatarImageView.kf.setImage(with: URL(string: url), options: [.forceRefresh])
    }

    private func setupChangePasswordButton() {
        changePasswordButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onChangePasswordTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                #if canImport(UIKit)
                    make.top.equalTo(changePhotoButton.snp.bottom)
                        .offset(GeometryConfiguration.Common.itemSpace)
                #else
                    make.top.equalTo(greetingLabel.snp.bottom)
                        .offset(3 * GeometryConfiguration.Common.itemSpace)
                #endif
            }
        }
    }

    @objc private func onChangePasswordTap() {
        coordinator?.openChangePasswordScreen()
    }

    func onPasswordChanged() {
        coordinator?.openSignInScreen()
    }

    private func setupLogoutButton() {
        logoutButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onLogoutTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(changePasswordButton.snp.bottom)
                    .offset(GeometryConfiguration.Common.itemSpace)
            }
        }
    }

    @objc private func onLogoutTap() {
        presenter.logout()
    }

    func onLogout() {
        coordinator?.openSignInScreen()
    }

    private func setupDeleteAccountButton() {
        deleteAccountButton = CAButton().then {
            view.addSubview($0)
            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onDeleteAccountTap))
            $0.snp.makeConstraints { make in
                setupItemConstraints(make: make)
                make.top.equalTo(logoutButton.snp.bottom)
                    .offset(GeometryConfiguration.Common.itemSpace)
                make.bottom.lessThanOrEqualToSuperviewSafe()
                    .inset(GeometryConfiguration.Common.itemsInset)
            }
        }
    }

    @objc private func onDeleteAccountTap() {
        presenter.deleteAccount()
    }
}

extension UserScreenBasic: Screen {}
