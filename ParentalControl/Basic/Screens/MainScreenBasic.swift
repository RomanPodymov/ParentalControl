//
//  MainScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 06/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import SnapKit
import SwifterSwift

class MainScreenBasic: CAScreenWithTabs {
    lazy var presenter = MainPresenter(screen: self, coordinator: coordinator)

    private weak var coordinator: Coordinator?

    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadCurrentUserId()
    }

    override func willAppear() {
        super.willAppear()

        ((selectedViewController as? KidsFlowNavigationController)?.viewControllers.last as? CAScreen)?.willAppear()
    }

    private func createKidsScreen() -> NavigationController {
        createScreen(
            navigationControllerType: KidsFlowNavigationController.self,
            rootScreen: KidsScreen(
                coordinator: coordinator,
                withCloseButton: false,
                withBackButton: false,
                customNavigationController: nil
            ),
            title: L10n.KidsScreen.title,
            systemImage: "figure.child"
        )
    }

    private func createTimeSlotsScreen(currentUserId: String?) -> NavigationController {
        let kidId: String = if Configuration.isParentApp {
            ""
        } else {
            currentUserId ?? ""
        }

        return createScreen(
            navigationControllerType: KidsFlowNavigationController.self,
            rootScreen: KidsTimeSlotsScreen(
                kidId: kidId,
                coordinator: coordinator,
                withCloseButton: false,
                withBackButton: true,
                customNavigationController: nil
            ),
            title: L10n.KidsTimeSlotsScreen.title,
            systemImage: "calendar.badge.clock"
        )
    }

    func onCurrentUserIdLoaded(id: String?) {
        if Configuration.isParentApp {
            viewControllers = [
                createKidsScreen(), createUserScreen()
            ]
        } else {
            viewControllers = [
                createTimeSlotsScreen(currentUserId: id), createUserScreen()
            ]
        }
    }

    private func createUserScreen() -> NavigationController {
        createScreen(
            navigationControllerType: UserFlowNavigationController.self,
            rootScreen: UserScreen(
                coordinator: coordinator,
                withCloseButton: false,
                withBackButton: false,
                customNavigationController: nil
            ),
            title: L10n.UserScreen.title,
            systemImage: "person.fill"
        )
    }

    private func createScreen(
        navigationControllerType: NavigationController.Type,
        rootScreen: CAScreen,
        title: String,
        systemImage: String
    ) -> NavigationController {
        let navigationController: NavigationController

        #if canImport(BFNavigationController)
            navigationController = navigationControllerType.init(
                frame: .init(x: 0, y: 0, width: 1, height: 1),
                rootViewController: rootScreen
            )!
        #elseif canImport(UIKit)
            navigationController = navigationControllerType.init(rootViewController: rootScreen)
        #endif

        navigationController.prepareToUseAsTab(title: title, systemImage: systemImage)

        return navigationController
    }
}

extension MainScreenBasic: Screen {}
