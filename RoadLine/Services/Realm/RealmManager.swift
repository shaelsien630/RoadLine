//
//  RealmManager.swift
//  RoadLine
//
//  Created by 최서희 on 11/12/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    // MARK: - 여행 추가(Create)
    func addTravel(_ travel: TravelObject) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(travel)
        }
    }
    
    // MARK: - 여행 수정(UPDATE)
    func updateTravel(by id: ObjectId) {
        let realm = try! Realm()
    }
    
    
    // MARK: - 여행 불러오기(READ)
    func fetchAllTravels() -> [TravelObject] {
        let realm = try! Realm()
        return Array(realm.objects(TravelObject.self))
    }

    // MARK: - 여행 삭제(DELETE)
    func deleteTravel(by id: ObjectId) {
        let realm = try! Realm() // do-catch 예외 상황 두기
        if let travel = realm.object(ofType: TravelObject.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(travel)
            }
        }
    }
    
    // // 특정 ID로 여행 정보 가져오기
    // func getTravel(by id: ObjectId) -> TravelObject? {
    //     let realm = try! Realm()
    //     return realm.object(ofType: TravelObject.self, forPrimaryKey: id)
    // }
}
