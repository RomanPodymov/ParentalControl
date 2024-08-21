//
//  AppDelegate.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import IQKeyboardManagerSwift
import SwifterSwift
import UIKit

public final class AppDelegate: AppDelegateBasic {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        initBE()
        IQKeyboardManager.shared.enable = true
        setupInitialScreen()

        return true
    }

    override func setupWindow(screen: CAViewController) {
        super.setupWindow(screen: screen)

        window ?= UIWindow(frame: UIScreen.main.bounds).then {
            $0.makeKeyAndVisible()
        }
        window?.rootViewController = screen
    }
}
