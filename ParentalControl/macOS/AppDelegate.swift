//
//  AppDelegate.swift
//  ParentalControl
//
//  Created by Roman Podymov on 14/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import AppKit
import CommonAppleKit
import SwifterSwift

public final class AppDelegate: AppDelegateBasic {
    func applicationDidFinishLaunching(_: Notification) {
        initBE()
        setupInitialScreen()
    }

    override func setupWindow(screen: CAViewController) {
        super.setupWindow(screen: screen)

        if let window {
            window.contentViewController = screen
        } else {
            window ?= CAWindow(contentViewController: screen).then {
                $0.makeKeyAndOrderFront(nil)
            }
        }
    }
}
