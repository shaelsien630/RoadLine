//
//  RealmManager.swift
//  RoadLine
//
//  Created by 최서희 on 11/12/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    // 조회
    func fetchAllTravels() async -> [TravelObject] {
        return await Task {
            let realm = try! Realm()
            let objects = realm.objects(TravelObject.self)
            // freeze()를 사용하여 thread-safe 객체로 변환
            return objects.map { $0.freeze() }
        }.value
    }
    
    // 추가
    func addTravel(_ travel: TravelObject) async throws {
        try await Task {
            let realm = try! Realm()
            try realm.write {
                realm.add(travel)
            }
        }.value
    }
    
    // 삭제
    func deleteTravel(by id: ObjectId) async throws {
        try await Task {
            let realm = try! Realm()
            guard let travel = realm.object(ofType: TravelObject.self, forPrimaryKey: id) else {
                throw NSError(domain: "RealmManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "해당 여행 데이터를 찾을 수 없습니다."])
            }
            try realm.write {
                realm.delete(travel)
            }
        }.value
    }
    
    // // 특정 ID로 여행 정보 가져오기
    // func getTravel(by id: ObjectId) -> TravelObject? {
    //     let realm = try! Realm()
    //     return realm.object(ofType: TravelObject.self, forPrimaryKey: id)
    // }
}

// MARK: - Travel 변환 확장 (Data Conversion)
extension Travel {
    init(from object: TravelObject) {
        self.id = object._id
        self.country = object.country
        self.departureDate = object.departureDate
        self.returnDate = object.returnDate
        self.notes = object.notes
        self.currency = object.currency
    }
}
