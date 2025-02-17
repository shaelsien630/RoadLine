//
//  TravelRepository.swift
//  RoadLine
//
//  Created by 최서희 on 11/12/24.
//

import Foundation
import RealmSwift
import ComposableArchitecture

final class TravelRepository {
    private let realmManager = RealmManager()

    // 여행 목록 가져오기
    func fetchAllTravels() async throws -> [Travel] {
        let objects = await realmManager.fetchAllTravels()
        return objects.map { Travel(from: $0) }
    }

    // 여행 추가
    func addTravel(
        country: String,
        departureDate: Date,
        returnDate: Date,
        notes: String,
        currency: String
    ) async throws {
        let newObject = TravelObject()
        newObject.country = country
        newObject.departureDate = departureDate
        newObject.returnDate = returnDate
        newObject.notes = notes
        newObject.currency = currency
        
        try await realmManager.addTravel(newObject)
    }

    // 여행 삭제
    func deleteTravel(by id: ObjectId) async throws {
        try await realmManager.deleteTravel(by: id)
    }
}

// MARK: - TCA Dependency 등록
extension DependencyValues {
    var travelRepository: TravelRepository {
        get { self[TravelRepositoryKey.self] }
        set { self[TravelRepositoryKey.self] = newValue }
    }
}

private enum TravelRepositoryKey: DependencyKey {
    static let liveValue = TravelRepository()
}
