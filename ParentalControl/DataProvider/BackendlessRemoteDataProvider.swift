//
//  BackendlessRemoteDataProvider.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import BackendlessAndPromises
import CommonAppleKit
import Foundation
import Promises
import SwifterSwift
import SwiftSDK

struct BackendlessRemoteDataProvider {
    static let shared = BackendlessRemoteDataProvider()

    static let queue = DispatchQueue.global(qos: .userInitiated)
    static let shouldRecoverFromLocalData = false

    private init() {}
}

extension BackendlessRemoteDataProvider: RemoteDataSignInRegisterProvider {
    var currentUser: Promise<UserInfo?> {
        guard let currentUser = Backendless.shared.userService.currentUser else {
            return .init(
                nil
            )
        }
        return .init(
            .init(
                id: currentUser.objectId ?? "",
                email: currentUser.email ?? "",
                isParent: currentUser.isParent as? Bool ?? false,
                avatar: (currentUser.avatar as? String).flatMap { .init(string: $0) }
            )
        )
    }

    var isValidUserToken: Promise<Bool> {
        Backendless.shared.userService.isValidUserToken(
            on: Self.queue
        )
    }

    func signIn(email: String, password: String) -> Promise<UserInfo> {
        Backendless.shared.userService.stayLoggedIn = true
        return Backendless.shared.userService.login(
            identity: email,
            password: password,
            on: Self.queue
        ).then(on: Self.queue) { user in
            checkAfterSignIn(
                user: user,
                shouldBeParent: Configuration.isParentApp
            )
        }.then(on: Self.queue) { user in
            .init(
                id: user.objectId ?? "",
                email: user.email ?? "",
                isParent: user.isParent as? Bool ?? false,
                avatar: (user.avatar as? String).flatMap { .init(string: $0) }
            )
        }
    }

    private func checkAfterSignIn(
        user: BackendlessUser,
        shouldBeParent: Bool
    ) -> Promise<BackendlessUser> {
        if let isParent = user.isParent as? Bool,
           (isParent && shouldBeParent) || (!isParent && !shouldBeParent)
        {
            .init(user)
        } else {
            logout().then(on: Self.queue) { _ in
                let error: RemoteDataProviderError
                error = (user.isParent as? Bool ?? false) ? .parentTryingToUseKidApp : .kidTryingToUseParentApp
                throw error
            }.then(on: Self.queue) { _ in
                user
            }
        }
    }

    func register(email: String, password: String, isParent: Bool) -> Promise<UserInfo> {
        let user = BackendlessUser()
        user.email = email
        user.password = password
        user.isParent = isParent

        return Backendless.shared.userService.registerUser(
            user: user,
            on: Self.queue
        ).then(on: Self.queue) {
            .init(
                .init(
                    id: $0.objectId ?? "",
                    email: $0.email ?? "",
                    isParent: $0.isParent as? Bool ?? false,
                    avatar: ($0.avatar as? String).flatMap { .init(string: $0) }
                )
            )
        }
    }

    func resetPassword(email: String) -> Promise<Void> {
        Backendless.shared.userService.restorePassword(
            identity: email,
            on: Self.queue
        )
    }

    func changePassword(newPassword: String) -> Promise<Void> {
        guard let currentUser = Backendless.shared.userService.currentUser else {
            return .init(RemoteDataProviderError.noCurrentUserWhenRequired)
        }
        currentUser.password = newPassword
        return Backendless.shared.userService.update(user: currentUser, on: Self.queue).then { _ in
            .init(())
        }
    }

    func logout() -> Promise<Void> {
        Backendless.shared.userService.logout(on: Self.queue)
    }

    func deleteAccount() -> Promise<Void> {
        let currentUserId = Backendless.shared.userService.currentUser!.objectId ?? ""
        return logout().then(on: Self.queue) { _ in
            var users: MapDrivenDataStore! = Backendless.shared.data.ofTable("Users")
            return users.removeById(objectId: currentUserId, on: Self.queue).then { _ in
                .init(())
            }.always {
                users = nil
            }
        }
    }

    func uploadPhoto(data: Data) -> Promise<String> {
        currentUser.then {
            Backendless.shared.fileService.uploadFile(
                fileName: ($0?.id ?? "") + ".jpg",
                filePath: "/avatar",
                content: data,
                overwrite: true
            )
        }.then { (file: BackendlessFile) in
            Backendless.shared.userService.currentUser?.avatar = file.fileUrl
            let users: MapDrivenDataStore! = Backendless.shared.data.ofTable("Users")
            return (
                file,
                users,
                users.addRelation(
                    columnName: "avatar",
                    parentObjectId: Backendless.shared.userService.currentUser?.objectId ?? "",
                    childrenObjectIds: [file.fileUrl ?? ""]
                )
            )
        }.then { (file: BackendlessFile, _, _) in
            .init(file.fileUrl ?? "")
        }
    }
}
