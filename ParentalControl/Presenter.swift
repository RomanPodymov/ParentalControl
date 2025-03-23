//
//  Presenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import Foundation

class BasicPresenter<ScreenType: Screen & AnyObject>: NSObject, Presenter {
    unowned var screen: ScreenType!
    weak var coordinator: Coordinator?

    required init(screen: ScreenType, coordinator: Coordinator?) {
        self.screen = screen
        self.coordinator = coordinator
    }

    var dataProvider: RemoteDataProvider? {
        coordinator?.resolve(
            dependency: RemoteDataProvider.self
        )
    }
}

protocol Presenter {
    associatedtype ScreenType

    var screen: ScreenType! { get set }
    var coordinator: Coordinator? { get set }
    init(screen: ScreenType, coordinator: Coordinator?)
}
