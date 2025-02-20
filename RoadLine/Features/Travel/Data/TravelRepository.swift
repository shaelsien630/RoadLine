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
    
    // 모든 여행 목록 조회
    func fetchAllTravels() async -> [Travel] {
        return await realmManager.fetchAllTravels()
    }
    
    // 여행 추가
    func addTravel(
        country: String,
        departureDate: Date,
        returnDate: Date,
        notes: String,
        currency: String
    ) async throws {
        try await realmManager.addTravel(
            country: country,
            departureDate: departureDate,
            returnDate: returnDate,
            notes: notes,
            currency: currency)
    }

    // 여행 삭제
    func deleteTravel(by id: ObjectId) async throws {
        try await realmManager.deleteTravel(by: id)
    }
}

