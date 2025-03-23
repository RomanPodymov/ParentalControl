//
//  DifferenceKitListView.swift
//  ParentalControl
//
//  Created by Roman Podymov on 05/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import DifferenceKit
import Foundation

class DifferenceKitListView<
    Cell: CAListViewCell<RootView>,
    Header: CACollectionReusableView,
    Footer: CACollectionReusableView,
    RootView,
    Data: Differentiable
>: CAScrollableListView<Cell, Header, Footer, RootView, Data> {
    #if canImport(UIKit)
        private var realContent: [Data] = []

        override var content: [Data] {
            get {
                realContent
            }

            set {
                previousContent = content
                let stagedSet = StagedChangeset(source: previousContent, target: newValue)
                reload(using: stagedSet) { [weak self] data in
                    self?.realContent = data
                }
                tryToDisplayBackgroundView()
            }
        }

        override func reload() {}
    #endif

    var emptyView: CAScreenItem? {
        didSet {
            #if canImport(UIKit)
                backgroundView = emptyView
                tryToDisplayBackgroundView()
            #endif
        }
    }

    private func tryToDisplayBackgroundView() {
        #if canImport(UIKit)
            backgroundView?.isHidden = !content.isEmpty
        #endif
    }
}
