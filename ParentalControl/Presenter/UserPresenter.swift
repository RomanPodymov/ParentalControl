//
//  UserPresenter.swift
//  ParentalControl
//
//  Created by Roman Podymov on 07/03/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import Foundation
import Promises
#if canImport(UIKit)
    import UIKit
#endif

final class UserPresenter: BasicPresenter<UserScreenBasic> {
    func loadUserInfo() {
        let loadingScreen = screen.displayLoading()
        dataProvider?.currentUser.then { [weak self] userInfo in
            self?.screen.onUserInfoSuccess(userInfo: userInfo)
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }

    func logout() {
        let loadingScreen = screen.displayLoading()
        dataProvider?.logout().then { [weak self] in
            self?.screen.onLogout()
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }

    func deleteAccount() {
        display(message: L10n.Alert.deleteAccountText, buttons: [.yes, .no]) { [weak self] in
            switch $0 {
            case 0:
                self?.deleteAccountAfterAlert()
            case 1:
                return
            default:
                return
            }
        }
    }

    private func deleteAccountAfterAlert() {
        let loadingScreen = screen.displayLoading()
        dataProvider?.deleteAccount().then { [weak self] in
            self?.screen.onLogout()
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }

    #if canImport(UIKit)
        weak var imagePickerController: UIImagePickerController?
    #endif

    func selectPhoto() {
        #if canImport(UIKit)
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.allowsEditing = true
            self.imagePickerController = imagePickerController
            screen.present(imagePickerController, animated: true, completion: {})
        #endif
    }

    func uploadPhoto(data: Data) {
        let loadingScreen = screen.displayLoading()
        dataProvider?.uploadPhoto(data: data).then { [weak self] in
            self?.screen.onPhotoSent(url: $0)
        }.catch { error in
            display(error: error)
        }.always {
            hideLoading(loadingScreen)
        }
    }
}

#if canImport(UIKit)
    extension UserPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerController(
            _: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[.editedImage] as? UIImage {
                screen.onPhotoSelected(image: image)
            }
            imagePickerController?.dismiss(animated: true)
        }
    }
#endif
