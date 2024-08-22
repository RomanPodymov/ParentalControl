//
//  TimeSlotsListView.swift
//  ParentalControl
//
//  Created by Roman Podymov on 21/01/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import CoreGraphics
import DifferenceKit
import Foundation
#if canImport(NVActivityIndicatorView)
    import NVActivityIndicatorView
#endif

extension TimeSlotData: Differentiable {
    func isContentEqual(to source: TimeSlotData) -> Bool {
        objectId == source.objectId
    }

    var differenceIdentifier: String {
        objectId
    }
}

class TimeSlotsFooter: CACollectionReusableView {
    #if canImport(NVActivityIndicatorView)
        unowned var loadingView: NVActivityIndicatorView!

        override init(frame: CGRect) {
            super.init(frame: frame)

            loadingView = NVActivityIndicatorView(frame: .zero, type: .ballBeat).then {
                addSubview($0)
                $0.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalTo(50)
                }
                $0.color = .black
                $0.startAnimating()
            }
        }

        required init?(coder _: NSCoder) {
            nil
        }
    #endif
}

class TimeSlotsListView: DifferenceKitListView<
    TimeSlotsScreenCell,
    CACollectionReusableView,
    TimeSlotsFooter,
    TimeSlotsCellRootView,
    TimeSlotData
> {}
