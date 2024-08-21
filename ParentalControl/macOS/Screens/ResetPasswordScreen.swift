//
//  ResetPasswordScreen.swift
//  ParentalControl
//
//  Created by Roman Podymov on 03/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

final class ResetPasswordScreen: ResetPasswordScreenBasic {
    override func viewDidAppear() {
        super.viewDidAppear()

        view.window?.title = L10n.RegisterScreen.title
    }
}
