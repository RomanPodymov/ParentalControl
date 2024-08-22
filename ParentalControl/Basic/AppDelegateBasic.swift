//
//  AppDelegateBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import Promises
import SwifterSwift
import Swinject
import Then
#if canImport(UIKit)
    import UIKit
#endif
#if canImport(BFNavigationController)
    import BFNavigationController
#endif

protocol Coordinator: AnyObject {
    func openLoadingScreen()
    func openMainScreen()
    func openKidTimeSlots(kidId: String)
    func openDurationScreen()
    func openAddKid(hours: Int?, minutes: Int?)

    func openSignInScreen()
    func openRegisterScreen()
    func openResetPasswordScreen()
    func openChangePasswordScreen()

    func openAddTimeSlots(isAdding: Bool, kidId: String)
    func resolve<Dependency>(dependency: Dependency.Type) -> Dependency?
}

extension Container: Then {}

public class AppDelegateBasic: CAAppDelegate {
    private lazy var depContainer = Container().then {
        $0.register(RemoteDataProvider.self) { _ in BackendlessRemoteDataProvider.shared }
    }

    func initBE() {
        let remoteDataProvider = resolve(dependency: RemoteDataProvider.self)
        remoteDataProvider?.setup()
    }

    func createMainScreen() -> CAViewController {
        let rootController = MainScreen(coordinator: self)
        return rootController
    }

    func setupInitialScreen() {
        openLoadingScreen()

        let remoteDataProvider = resolve(dependency: RemoteDataProvider.self)
        remoteDataProvider?.isValidUserToken.then { [weak self] isValidUserToken in
            isValidUserToken ? self?.openMainScreen() : self?.openSignInScreen()
        }.catch { error in
            display(error: error as NSError)
        }
    }

    func setupWindow(screen _: CAViewController) {}
}

#if canImport(UIKit)
    typealias NavigationController = UINavigationController
#elseif canImport(AppKit)
    typealias NavigationController = BFNavigationController
#endif

final class SignInFlowNavigationController: NavigationController {}
final class KidsFlowNavigationController: NavigationController {}
final class UserFlowNavigationController: NavigationController {}

extension AppDelegateBasic: Coordinator {
    func openLoadingScreen() {
        setupWindow(
            screen: LoadingScreen(
                coordinator: self,
                withCloseButton: false,
                withBackButton: false,
                customNavigationController: nil
            )
        )
    }

    func openMainScreen() {
        let rootScreen = window?.rootViewController
        if let mainScreen = rootScreen as? MainScreen {
            mainScreen.willAppear()
            mainScreen.presentedViewControllers?.forEach {
                mainScreen.dismiss($0)
            }
            mainScreen.didAppear()
        } else {
            setupWindow(screen: createMainScreen())
        }
    }

    func openKidTimeSlots(kidId: String) {
        if let rootViewController = window?.rootViewController {
            rootViewController.presentedViewControllers?.forEach {
                rootViewController.dismiss($0)
            }
        }
        if let mainScreen = window?.rootViewController as? MainScreen {
            if let kidsFlowNavigationController = mainScreen.viewControllers?.first as? KidsFlowNavigationController {
                if let current = kidsFlowNavigationController.viewControllers.last as? KidsTimeSlotsScreen {
                    current.willAppear()
                } else {
                    let screen = KidsTimeSlotsScreen(
                        kidId: kidId,
                        coordinator: self,
                        withCloseButton: false,
                        withBackButton: true,
                        customNavigationController: kidsFlowNavigationController
                    )
                    kidsFlowNavigationController.pushViewController(screen, animated: true)
                }
            }
        }
    }

    func openDurationScreen() {
        let durationScreen = DurationScreen(
            coordinator: self,
            withCloseButton: true,
            withBackButton: false,
            customNavigationController: nil
        )
        let rootScreen = window?.rootViewController
        rootScreen?.present(durationScreen)
    }

    func openAddKid(hours: Int?, minutes: Int?) {
        if let _, let _ {
            let _ = window?.rootViewController as? DurationScreen

        } else {
            let addKidScreen = AddKidScreen(
                coordinator: self,
                withCloseButton: true,
                withBackButton: false,
                customNavigationController: nil
            )
            let rootScreen = window?.rootViewController
            rootScreen?.present(addKidScreen)
        }
    }

    func openSignInScreen() {
        if !tryToPopToSignInScreen() {
            let signInScreen = SignInScreen(
                coordinator: self,
                withCloseButton: false,
                withBackButton: false,
                customNavigationController: nil
            )
            let newSignInFlowNavigationController: SignInFlowNavigationController
            #if canImport(BFNavigationController)
                newSignInFlowNavigationController = SignInFlowNavigationController(
                    frame: .init(x: 0, y: 0, width: 1, height: 1),
                    rootViewController: signInScreen
                )
            #elseif canImport(UIKit)
                newSignInFlowNavigationController = SignInFlowNavigationController(
                    rootViewController: signInScreen
                )
            #endif
            setupWindow(screen: newSignInFlowNavigationController)
        }
    }

    private func tryToPopToSignInScreen() -> Bool {
        if let signInFlowNavigationController = window?.rootViewController as? SignInFlowNavigationController,
           let signInScreen = signInFlowNavigationController.viewControllers.first(where: {
               $0 is SignInScreen
           })
        {
            #if canImport(BFNavigationController)
                signInFlowNavigationController.pop(
                    to: signInScreen,
                    animated: true
                )
            #elseif canImport(UIKit)
                signInFlowNavigationController.popToViewController(
                    signInScreen,
                    animated: true
                )
            #endif
            return true
        }
        return false
    }

    func openResetPasswordScreen() {
        let customNavigationController = window?.rootViewController as? SignInFlowNavigationController
        let resetPasswordScreen = ResetPasswordScreen(
            coordinator: self,
            withCloseButton: false,
            withBackButton: true,
            customNavigationController: customNavigationController
        )
        customNavigationController?.pushViewController(
            resetPasswordScreen,
            animated: true
        )
    }

    func openRegisterScreen() {
        let customNavigationController = window?.rootViewController as? SignInFlowNavigationController
        let registerScreen = RegisterScreen(
            coordinator: self,
            withCloseButton: false,
            withBackButton: true,
            customNavigationController: customNavigationController
        )
        customNavigationController?.pushViewController(
            registerScreen,
            animated: true
        )
    }

    func openChangePasswordScreen() {
        if let mainScreen = window?.rootViewController as? MainScreen {
            if let userFlowNavigationController = mainScreen.viewControllers?[safe: 1] as? UserFlowNavigationController {
                let changePasswordScreen = ChangePasswordScreen(
                    coordinator: self,
                    withCloseButton: false,
                    withBackButton: true,
                    customNavigationController: userFlowNavigationController
                )
                userFlowNavigationController.pushViewController(changePasswordScreen, animated: true)
            }
        }
    }

    func openAddTimeSlots(isAdding: Bool, kidId: String) {
        let addTimeSlotScreen = AddTimeSlotScreen(
            isAdding: isAdding,
            kidId: kidId,
            coordinator: self,
            withCloseButton: true,
            withBackButton: false,
            customNavigationController: nil
        )
        let rootScreen = window?.rootViewController
        rootScreen?.present(addTimeSlotScreen)
    }

    func resolve<Dependency>(dependency: Dependency.Type) -> Dependency? {
        depContainer.resolve(dependency)
    }
}
