//
//  LoadingScreenBasic.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

#if canImport(AppKit)
    import AppKit
#else
    import NVActivityIndicatorView
#endif
import CommonAppleKit
import SnapKit

class LoadingScreenBasic: BasicScreen<LoadingPresenter> {
    #if canImport(AppKit)
        private unowned var activityIndicatorView: NSProgressIndicator!
    #elseif canImport(NVActivityIndicatorView)
        private unowned var activityIndicatorViewLight: NVActivityIndicatorView!
        private unowned var activityIndicatorViewDark: NVActivityIndicatorView!
    #endif

    override func viewDidLoad() {
        super.viewDidLoad()

        #if canImport(AppKit)
            setupNSProgressIndicator()
        #elseif canImport(NVActivityIndicatorView)
            setupNVActivityIndicators()
        #endif
        setupColors()
    }

    #if canImport(AppKit)
        private func setupNSProgressIndicator() {
            view.addSubview(NSProgressIndicator().then {
                activityIndicatorView = $0
                view.addSubview($0)
                $0.style = .spinning
                $0.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalTo(50)
                }
                $0.startAnimation(self)
            })
        }

    #elseif canImport(NVActivityIndicatorView)
        private func setupNVActivityIndicators() {
            createNVActivityIndicator().do {
                activityIndicatorViewLight = $0
            }
            createNVActivityIndicator().do {
                activityIndicatorViewDark = $0
            }
        }

        private func createNVActivityIndicator() -> NVActivityIndicatorView {
            NVActivityIndicatorView(frame: .zero, type: .ballBeat).then {
                view.addSubview($0)
                $0.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalTo(50)
                }
                $0.startAnimating()
            }
        }
    #endif

    override open func didChangeTraitCollection() {
        setupColors()
    }

    private func setupColors() {
        let viewBackgroundColor = ColorsConfiguration.backgroundColor(traitCollection: traitCollection)
        let labelTextColor = { userInterfaceStyle in
            ColorsConfiguration.textColor(userInterfaceStyle: userInterfaceStyle)
        }

        view.backgroundColor = viewBackgroundColor
        #if canImport(AppKit)

        #elseif canImport(NVActivityIndicatorView)
            activityIndicatorViewLight.color = labelTextColor(.light)
            activityIndicatorViewDark.color = labelTextColor(.dark)

            switch traitCollection.userInterfaceStyle {
            case .dark:
                activityIndicatorViewLight.isHidden = true
                activityIndicatorViewDark.isHidden = false
            default:
                activityIndicatorViewLight.isHidden = false
                activityIndicatorViewDark.isHidden = true
            }
        #endif
    }
}

extension LoadingScreenBasic: Screen {}
