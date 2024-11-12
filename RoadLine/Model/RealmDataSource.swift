//
//  RealmDataSource.swift
//  RoadLine
//
//  Created by 최서희 on 11/12/24.
//

import Foundation
import RealmSwift
import Combine

final class RealmDataSource {
    private let realm = try! Realm()
    
    func fetchAllTravels() -> [Travel] {
        return Array(realm.objects(Travel.self))
    }
    
    func fetchComingTravels() -> Results<Travel> {
        let currentDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        return realm.objects(Travel.self)
            .filter("returnDate > %@", currentDate)
            .sorted(byKeyPath: "departureDate", ascending: true)
    }
    
    func fetchPastTravels() -> Results<Travel> {
        let currentDate = Date()
        return realm.objects(Travel.self)
            .filter("returnDate < %@", currentDate)
            .sorted(byKeyPath: "departureDate", ascending: false)
    }
    
    // 특정 ID로 여행 정보 가져오기
    func getTravel(by id: ObjectId) -> Travel? {
        return realm.object(ofType: Travel.self, forPrimaryKey: id)
    }

    // 여행 추가
    func addTravel(_ travel: Travel) {
        try! realm.write {
            realm.add(travel)
        }
    }

    // 여행 삭제
    func deleteTravel(by id: ObjectId) {
        if let travel = realm.object(ofType: Travel.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(travel)
            }
        }
    }
}
