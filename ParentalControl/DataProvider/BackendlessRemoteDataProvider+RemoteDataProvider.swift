//
//  BackendlessRemoteDataProvider+RemoteDataProvider.swift
//  ParentalControl
//
//  Created by Roman Podymov on 13/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import BackendlessAndPromises
import Foundation
import Promises
import SwifterSwift
import SwiftSDK

extension BackendlessRemoteDataProvider: RemoteDataProvider {
    func setup() {
        guard let applicationId = Bundle.main.object(forInfoDictionaryKey: "BACKENDLESS_APP_ID") as? String else {
            return
        }
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "BACKENDLESS_API_KEY") as? String else {
            return
        }

        Backendless.shared.hostUrl = "http://eu-api.backendless.com"
        Backendless.shared.initApp(
            applicationId: applicationId,
            apiKey: apiKey
        )
    }

    private func kidsCount(forCurrentParent: Bool) -> Promise<Int> {
        let query = DataQueryBuilder()
        query.whereClause = [
            Self.isKidClause,
            Self.isParentClause(forCurrentParent: forCurrentParent),
        ].compactMap { $0 }.joined(separator: " AND ")
        var users: MapDrivenDataStore! = Backendless.shared.data.ofTable("Users")
        return users.getObjectCount(queryBuilder: query, on: Self.queue).always(on: Self.queue) {
            users = nil
        }
    }

    func addKid(email: String) -> Promise<Void> {
        kidsCount(forCurrentParent: false).then(on: Self.queue) {
            loadBackendlessKidsRaw(count: $0, forCurrentParent: false)
        }.then { kids in
            guard let kid = kids.first(where: { $0["email"] as? String == email }) else {
                throw RemoteDataProviderError.noKidForEmailFound
            }
            guard let currentUser = Backendless.shared.userService.currentUser else {
                throw RemoteDataProviderError.noCurrentUserWhenRequired
            }

            var users: MapDrivenDataStore! = Backendless.shared.data.ofTable("Users")
            let currentUserId = currentUser.objectId ?? ""
            let kidId = kid["objectId"] as? String ?? ""
            return users.addRelation(
                columnName: "parent",
                parentObjectId: kidId,
                childrenObjectIds: [currentUserId],
                on: Self.queue
            ).then { _ in
                .init(())
            }.always {
                users = nil
            }
        }
    }

    func loadKids() -> Promise<[KidData]> {
        kidsCount(forCurrentParent: true).then(on: Self.queue) {
            loadKids(count: $0, forCurrentParent: true)
        }
    }

    func loadBackendlessKids(forCurrentParent: Bool) -> Promise<[BackendlessUser]> {
        kidsCount(forCurrentParent: forCurrentParent).then(on: Self.queue) {
            loadBackendlessKids(count: $0, forCurrentParent: true)
        }
    }

    private static func isParentClause(forCurrentParent: Bool) -> String? {
        if forCurrentParent, let currentUserId = Backendless.shared.userService.currentUser?.objectId {
            "parent='" + currentUserId + "'"
        } else {
            nil
        }
    }

    private static var isKidClause: String {
        "isParent=FALSE"
    }

    private static var isCurrentUserClause: String? {
        if let currentUserId = Backendless.shared.userService.currentUser?.objectId {
            "ownerId='" + currentUserId + "'"
        } else {
            nil
        }
    }

    private static func kidClause(kidId: String) -> String {
        "kid='" + kidId + "'"
    }

    private func loadBackendlessKidsRaw(count: Int, forCurrentParent: Bool) -> Promise<[[String: Any]]> {
        let query = DataQueryBuilder()
        query.whereClause = [
            Self.isKidClause,
            Self.isParentClause(forCurrentParent: forCurrentParent),
        ].compactMap { $0 }.joined(separator: " AND ")
        query.pageSize = count
        var users: MapDrivenDataStore! = Backendless.shared.data.ofTable("Users")
        return users.find(queryBuilder: query, on: Self.queue).always(on: Self.queue) {
            users = nil
        }
    }

    private func loadBackendlessKids(count: Int, forCurrentParent: Bool) -> Promise<[BackendlessUser]> {
        loadBackendlessKidsRaw(count: count, forCurrentParent: forCurrentParent).then(on: Self.queue) { rawKids in
            rawKids.compactMap {
                if let jsonData = $0.jsonData() {
                    let result = try? JSONDecoder().decode(BackendlessUser.self, from: jsonData)
                    result?.properties = $0
                    return result
                }
                return nil
            }
        }
    }

    private func loadKids(count: Int, forCurrentParent: Bool) -> Promise<[KidData]> {
        loadBackendlessKids(count: count, forCurrentParent: forCurrentParent).then(on: Self.queue) { kids in
            kids.compactMap {
                guard let objectId = $0.objectId, let email = $0.email else {
                    return nil
                }
                return KidData(objectId: objectId, email: email, avatar: $0.avatar as? String)
            }
        }
    }

    func loadTimeSlots(kidId: String, offset: Int, maxCount: Int? = nil) -> Promise<([TimeSlotData], Int)> {
        timeSlotsCount(
            kidId: kidId
        ).then(on: Self.queue) { totalItemsCount in
            loadTimeSlots(
                kidId: kidId,
                offset: (maxCount ?? 0) * offset,
                count: maxCount ?? totalItemsCount
            ).then {
                ($0, totalItemsCount)
            }
        }
    }

    private func loadTimeSlots(kidId: String, offset: Int, count: Int) -> Promise<[TimeSlotData]> {
        .init(on: Self.queue) { onSuccess, onError in
            let query = DataQueryBuilder()
            query.whereClause = [
                // Self.isCurrentUserClause,
                Self.kidClause(kidId: kidId),
            ].compactMap { $0 }.joined(separator: " AND ")
            query.sortBy = ["created DESC"]
            query.offset = offset
            query.pageSize = count
            Backendless.shared.data.ofTable("TimeSlots").find(queryBuilder: query) { result in
                let timeSlots: [TimeSlotData] = result.compactMap { data -> TimeSlotData? in
                    guard let objectId = data["objectId"] as? String,
                          let amountMinutes = data["amountMinutes"] as? Int,
                          let text = data["text"] as? String,
                          let isAdding = data["isAdding"] as? Bool,
                          let ownerId = data["ownerId"] as? String,
                          let created = data["created"] as? Int64
                    else {
                        return nil
                    }
                    let startDate = data["startDate"] as? Int64
                    return TimeSlotData(
                        objectId: objectId,
                        startDate: startDate.map { Date(timeIntervalSince1970: Double($0) / 1000) },
                        activityDuration: amountMinutes,
                        activityDescription: text,
                        isAdding: isAdding,
                        ownerId: ownerId,
                        kidId: "",
                        created: Date(timeIntervalSince1970: Double(created) / 1000)
                    )
                }
                onSuccess(timeSlots)
            } errorHandler: { error in
                onError(error)
            }
        }
    }

    private func timeSlotsCount(kidId: String) -> Promise<Int> {
        let query = DataQueryBuilder()
        query.whereClause = [
            Self.kidClause(kidId: kidId),
        ].compactMap { $0 }.joined(separator: " AND ")
        var timeSlots: MapDrivenDataStore! = Backendless.shared.data.ofTable("TimeSlots")
        return timeSlots.getObjectCount(queryBuilder: query, on: Self.queue).always {
            timeSlots = nil
        }
    }

    func addTimeSlot(timeSlot: TimeSlotData) -> Promise<Void> {
        availableTimeUsingSign(kidId: timeSlot.kidId).then {
            let nextTime = timeSlot.isAdding ? $0 + timeSlot.activityDuration : $0 - timeSlot.activityDuration
            if nextTime < 0 {
                // TODO: no negative
            }
            if Configuration.isParentApp {
                return addTimeSlotVerified(timeSlot: timeSlot, currentKid: nil)
            } else {
                return addTimeSlotVerified(timeSlot: timeSlot, currentKid: Backendless.shared.userService.currentUser)
            }
        }
    }

    private func addTimeSlotVerified(timeSlot: TimeSlotData, currentKid: BackendlessUser?) -> Promise<Void> {
        let kidUser: Promise<BackendlessUser> = currentKid.map {
            Promise<BackendlessUser>($0)
        } ?? loadBackendlessKids(forCurrentParent: true).then(on: Self.queue) { kids in
            guard let kid = kids.first(where: { $0.objectId == timeSlot.kidId }) else {
                throw RemoteDataProviderError.kidForIdNotFound
            }
            return .init(kid)
        }
        return kidUser.then(on: Self.queue) { kid in
            var timeSlots: MapDrivenDataStore! = Backendless.shared.data.ofTable("TimeSlots")
            var timeSlotDict = [String: Any]()
            timeSlotDict["amountMinutes"] = timeSlot.activityDuration
            timeSlotDict["text"] = timeSlot.activityDescription
            timeSlotDict["isAdding"] = timeSlot.isAdding
            timeSlotDict["startDate"] = timeSlot.startDate
            return timeSlots.deepSave(entity: timeSlotDict).then { slot in
                timeSlots.addRelation(
                    columnName: "kid",
                    parentObjectId: slot["objectId"] as? String ?? "",
                    childrenObjectIds: [kid.objectId ?? ""],
                    on: Self.queue
                )
            }.then { _ in
                .init(())
            }.always {
                timeSlots = nil
            }
        }
    }

    func deleteTimeSlot(id: String) -> Promise<Void> {
        var timeSlots: MapDrivenDataStore! = Backendless.shared.data.ofTable("TimeSlots")
        return timeSlots.removeById(objectId: id).then { _ in
            .init(())
        }.always {
            timeSlots = nil
        }
    }

    func availableTimeUsingSign(kidId: String) -> Promise<Int> {
        loadTimeSlots(kidId: kidId, offset: 0, maxCount: nil).then(on: Self.queue) { slots in
            let duration = slots.0.reduce(0) { result, slot in
                slot.isAdding ? result + slot.activityDuration : result - slot.activityDuration
            }
            return .init(on: Self.queue) { onSuccess, _ in
                onSuccess(duration)
            }
        }
    }
}
