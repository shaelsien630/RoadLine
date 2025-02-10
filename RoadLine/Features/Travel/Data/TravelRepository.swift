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
    
    @MainActor
    // 전체 여행 목록 조회
    func fetchAllTravels() async -> [Travel] {
        let objects = realmManager.fetchAllTravels() // [Travel]
        return objects.map { obj in
            Travel(
                id: obj._id,
                country: obj.country,
                departureDate: obj.departureDate,
                returnDate: obj.returnDate,
                notes: obj.notes,
                currency: obj.currency
            )
        }
    }
    
    @MainActor
    // 여행 추가
    func addTravel(
        country: String,
        departureDate: Date,
        returnDate: Date,
        notes: String,
        currency: String
    ) async {
        let newObject = TravelObject()
        newObject.country = country
        newObject.departureDate = departureDate
        newObject.returnDate = returnDate
        newObject.notes = notes
        newObject.currency = currency
        // Primary Key(_id)는 기본값 .generate()로 자동 생성됨
        
        realmManager.addTravel(newObject)
    }
    
    @MainActor
    // 여행 업데이트
    func updateTravel(by id: ObjectId) async {
        realmManager.updateTravel(by: id)
    }
    
    @MainActor
    // 여행 삭제
    func deleteTravel(by id: ObjectId) async {
        realmManager.deleteTravel(by: id)
    }
    
    // @MainActor
    // // 특정 여행 조회
    // func getTravel(by id: ObjectId) async -> Travel? {
    //     return realmManager.getTravel(by: id)
    // }
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
