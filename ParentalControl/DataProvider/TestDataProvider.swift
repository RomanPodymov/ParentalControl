//
//  TestDataProvider.swift
//  ParentalControl
//
//  Created by Roman Podymov on 17/04/2024.
//  Copyright © 2024 ParentalControl. All rights reserved.
//

import CommonAppleKit
import Foundation
import Promises

class TestDataProvider: RemoteDataProvider {
    static let shared = TestDataProvider()

    private init() {}

    func setup() {}

    func loadKids() -> Promise<[KidData]> {
        .init([
            .init(objectId: "1", email: "someone@email.cz", avatar: nil),
            .init(objectId: "2", email: "other@email.cz", avatar: nil),
            .init(objectId: "3", email: "another@email.cz", avatar: nil)
        ])
    }

    func addKid(email _: String) -> Promise<Void> {
        .init(())
    }

    func loadTimeSlots(kidId _: String, offset _: Int, maxCount _: Int?) -> Promise<([TimeSlotData], Int)> {
        .init(
            ([
                .init(
                    objectId: "1",
                    startDate: Date(),
                    activityDuration: 100,
                    activityDescription: "Something",
                    isAdding: true,
                    ownerId: "1",
                    kidId: "2",
                    created: Date()
                )
            ],
            1)
        )
    }

    func addTimeSlot(timeSlot _: TimeSlotData) -> Promise<Void> {
        fatalError()
    }

    func deleteTimeSlot(id _: String) -> Promise<Void> {
        fatalError()
    }

    func availableTimeUsingSign(kidId _: String) -> Promise<Int> {
        .init(100)
    }

    var currentUser: Promise<UserInfo?> {
        .init(.init(id: "1", email: "someone@email.cz", isParent: true, avatar: nil))
    }

    var isValidUserToken: Promise<Bool> {
        .init(true)
    }

    func signIn(email _: String, password _: String) -> Promise<UserInfo> {
        fatalError()
    }

    func register(email _: String, password _: String, isParent _: Bool) -> Promise<UserInfo> {
        fatalError()
    }

    func resetPassword(email _: String) -> Promise<Void> {
        fatalError()
    }

    func changePassword(newPassword _: String) -> Promise<Void> {
        fatalError()
    }

    func logout() -> Promise<Void> {
        fatalError()
    }

    func deleteAccount() -> Promise<Void> {
        fatalError()
    }

    func uploadPhoto(data _: Data) -> Promise<String> {
        fatalError()
    }
}
