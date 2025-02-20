//
//  Travel.swift
//  RoadLine
//
//  Created by 최서희 on 2/10/25.
//

import Foundation
import RealmSwift

// Realm 모델 정의
final class TravelObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId = .generate()  // 고유 ID
    @Persisted var country: String = ""                 // 여행하는 나라
    @Persisted var departureDate: Date = Date()         // 출발일
    @Persisted var returnDate: Date = Date()            // 도착일
    @Persisted var notes: String = ""                   // 여행 메모
    @Persisted var currency: String = ""                // 여행 통화 (가계부에 사용)
    @Persisted var schedules = List<ScheduleObject>()   // 여행마다 일정들 포함 (관계형)
}

struct Travel: Identifiable, Equatable {
    let id: ObjectId
    let country: String
    let departureDate: Date
    let returnDate: Date
    let notes: String
    let currency: String
    var schedules: [Schedule] = []
    
    // `TravelObject` → `Travel` 변환
    init(from object: TravelObject) {
        self.id = object._id
        self.country = object.country
        self.departureDate = object.departureDate
        self.returnDate = object.returnDate
        self.notes = object.notes
        self.currency = object.currency
        self.schedules = object.schedules.map { Schedule(from: $0) }
    }
    
    // Travel에서 TravelObject로 변환 (Realm 저장 시)
    func toObject() -> TravelObject {
        let travelObject = TravelObject()
        travelObject._id = self.id
        travelObject.country = self.country
        travelObject.departureDate = self.departureDate
        travelObject.returnDate = self.returnDate
        travelObject.notes = self.notes
        travelObject.currency = self.currency
        travelObject.schedules.append(objectsIn: self.schedules.map { $0.toObject() }) // 일정 변환
        return travelObject
    }
}
