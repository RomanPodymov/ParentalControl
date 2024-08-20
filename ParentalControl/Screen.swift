//
//  Screen.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
#if canImport(SwiftAlertView)
    import SwiftAlertView
#elseif canImport(AppKit)
    import AppKit
#endif

protocol Screen {
    associatedtype PresenterType

    var presenter: PresenterType { get }
}

enum AlertButton {
    case ok
    case yes
    case no

    var translation: String {
        switch self {
        case .ok:
            L10n.Alert.defaultButton
        case .yes:
            L10n.Alert.yesButton
        case .no:
            L10n.Alert.noButton
        }
    }
}

func display(message: String, buttons: [AlertButton] = [.ok], onButtonClicked: ((Int) -> Void)? = nil) {
    #if canImport(SwiftAlertView)
        SwiftAlertView.show(
            title: L10n.Alert.defaultTitle,
            message: message,
            buttonTitles: buttons.map(\.translation)
        ).onButtonClicked { _, buttonIndex in
            onButtonClicked?(buttonIndex)
        }
    #elseif canImport(AppKit)
        let alert = NSAlert()
        alert.informativeText = message
        for button in buttons {
            alert.addButton(withTitle: button.translation)
        }
        let result = alert.runModal()
        switch result {
        case .alertFirstButtonReturn:
            onButtonClicked?(0)
        case .alertSecondButtonReturn:
            onButtonClicked?(1)
        default:
            onButtonClicked?(-1)
        }
    #endif
}

func display(error: Error) {
    display(message: error.localizedDescription)
}

extension Screen where Self: CAViewController {
    func displayLoading() -> LoadingScreen {
        let loadingScreen = LoadingScreen(
            coordinator: nil,
            withCloseButton: false,
            withBackButton: false,
            customNavigationController: nil
        )
        #if canImport(UIKit)
            addChildViewController(loadingScreen, toContainerView: view)
        #endif
        return loadingScreen
    }
}

func hideLoading(_ screen: LoadingScreen) {
    #if canImport(UIKit)
        screen.removeViewAndControllerFromParentViewController()
    #endif
}

class BasicScreen<P: Presenter>: CAScreen {
    // swiftlint:disable:next force_cast
    lazy var presenter = P(screen: self as! P.ScreenType, coordinator: coordinator)

    weak var coordinator: Coordinator?

    private unowned var closeButton: CAButton!
    private unowned var backButton: CAButton!

    private let withCloseButton: Bool
    private let withBackButton: Bool
    private weak var customNavigationController: NavigationController?

    required init(
        coordinator: Coordinator?,
        withCloseButton: Bool,
        withBackButton: Bool,
        customNavigationController: NavigationController?
    ) {
        self.coordinator = coordinator
        self.withCloseButton = withCloseButton
        self.withBackButton = withBackButton
        self.customNavigationController = customNavigationController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if withCloseButton {
            setupCloseButton()
        }
        #if os(macOS)
            if withBackButton {
                setupBackButton()
            }
        #endif
    }

    func setupCloseButton() {
        closeButton = .init().then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview().inset(GeometryConfiguration.Common.itemSpaceSmall)
            }
            $0.setSystemImage(
                "xmark.circle",
                tintColor: .red,
                newSize: .init(
                    width: GeometryConfiguration.Common.buttonSize,
                    height: GeometryConfiguration.Common.buttonSize
                )
            )

            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onCloseButtonTap))
        }
    }

    @objc private func onCloseButtonTap() {
        dismiss(self)
    }

    func setupBackButton() {
        backButton = .init().then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().inset(GeometryConfiguration.Common.itemSpaceSmall)
            }
            $0.setSystemImage(
                "arrowshape.backward.fill",
                tintColor: .red,
                newSize: .init(
                    width: GeometryConfiguration.Common.buttonSize,
                    height: GeometryConfiguration.Common.buttonSize
                )
            )

            $0.addTargetForPrimaryActionTriggered(self, action: #selector(Self.onBackButtonTap))
        }
    }

    @objc private func onBackButtonTap() {
        customNavigationController?.popViewController(animated: true)
    }
}
