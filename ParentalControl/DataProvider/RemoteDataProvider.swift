//
//  RemoteDataProvider.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import Promises

struct UserInfo {
    let id: String
    let email: String
    let isParent: Bool
    let avatar: URL?
}

struct TimeSlotData {
    let objectId: String
    let startDate: Date?
    let activityDuration: Int
    let activityDescription: String
    let isAdding: Bool
    let ownerId: String
    let kidId: String
    let created: Date
}

extension TimeSlotData: Equatable {
    public static func == (lhs: TimeSlotData, rhs: TimeSlotData) -> Bool {
        lhs.objectId == rhs.objectId
    }
}

extension TimeSlotData: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(objectId)
    }
}

enum RemoteDataProviderError: Error {
    case nilSelf
    case noKidForEmailFound
    case kidAlreadyHasParent
    case noCurrentUserWhenRequired
    case kidTryingToUseParentApp
    case parentTryingToUseKidApp
    case kidForIdNotFound
    case cannotAddTimeSlotBecauseNoTimeLeft
}

extension RemoteDataProviderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .nilSelf:
            L10n.Error.nilSelf
        case .noKidForEmailFound:
            L10n.Error.noKidForEmailFound
        case .kidAlreadyHasParent:
            L10n.Error.kidAlreadyHasParent
        case .noCurrentUserWhenRequired:
            L10n.Error.noCurrentUserWhenRequired
        case .kidTryingToUseParentApp:
            L10n.Error.kidTryingToUseParentApp
        case .parentTryingToUseKidApp:
            L10n.Error.parentTryingToUseKidApp
        case .kidForIdNotFound:
            L10n.Error.kidForIdNotFound
        case .cannotAddTimeSlotBecauseNoTimeLeft:
            L10n.Error.cannotAddTimeSlotBecauseNoTimeLeft
        }
    }
}

protocol RemoteDataSignInRegisterProvider {
    var currentUser: Promise<UserInfo?> { get }
    var isValidUserToken: Promise<Bool> { get }
    func signIn(email: String, password: String) -> Promise<UserInfo>
    func register(email: String, password: String, isParent: Bool) -> Promise<UserInfo>
    func resetPassword(email: String) -> Promise<Void>
    func changePassword(newPassword: String) -> Promise<Void>
    func logout() -> Promise<Void>
    func deleteAccount() -> Promise<Void>
    func uploadPhoto(data: Data) -> Promise<String>
}

protocol RemoteDataProvider: RemoteDataSignInRegisterProvider {
    func setup()
    func loadKids() -> Promise<[KidData]>
    func addKid(email: String) -> Promise<Void>

    func loadTimeSlots(kidId: String, offset: Int, maxCount: Int?) -> Promise<([TimeSlotData], Int)>
    func addTimeSlot(timeSlot: TimeSlotData) -> Promise<Void>
    func deleteTimeSlot(id: String) -> Promise<Void>
    func availableTimeUsingSign(kidId: String) -> Promise<Int>
}

protocol RecoveringDataProvider: RemoteDataProvider {}
