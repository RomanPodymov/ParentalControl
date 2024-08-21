//
//  SignInScreen.swift
//  ParentalControl
//
//  Created by Roman Podymov on 14/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

final class SignInScreen: SignInScreenBasic {
    override func viewDidAppear() {
        super.viewDidAppear()

        view.window?.title = L10n.SigninScreen.title
    }
}
