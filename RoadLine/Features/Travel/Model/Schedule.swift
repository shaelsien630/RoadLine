//
//  Schedule.swift
//  RoadLine
//
//  Created by 최서희 on 2/18/25.
//

import Foundation
import RealmSwift

// 각 일정 마다 어떤 여행의 몇일차, 몇번째 일정인지가 필요함
final class ScheduleObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId = .generate()  // 고유 ID
    @Persisted var travelId: ObjectId       // 해당 일정이 속한 여행(Travel)의 ID
    @Persisted var date: Date = Date()      // 여행에서 몇 번째 날인지 저장
    @Persisted var title: String = ""       // 일정 제목
    @Persisted var location: String = ""    // 일정 장소
    @Persisted var time: String = ""        // 일정 시간
    @Persisted var notes: String = ""       // 추가 메모
    @Persisted var order: Int = 0           // 일정 순서 (낮을수록 먼저)
}

struct Schedule: Identifiable, Equatable {
    let id: ObjectId
    let travelId: ObjectId
    let date: Date
    let title: String
    let location: String
    var time: String
    let notes: String
    var order: Int

    // `ScheduleObject` → `Schedule` 변환
    init(from object: ScheduleObject) {
        self.id = object._id
        self.travelId = object.travelId
        self.date = object.date
        self.title = object.title
        self.location = object.location
        self.time = object.time
        self.notes = object.notes
        self.order = object.order
    }

    // `Schedule` → `ScheduleObject` 변환
    func toObject() -> ScheduleObject {
        let scheduleObject = ScheduleObject()
        scheduleObject._id = self.id
        scheduleObject.travelId = self.travelId
        scheduleObject.date = self.date
        scheduleObject.title = self.title
        scheduleObject.location = self.location
        scheduleObject.time = self.time
        scheduleObject.notes = self.notes
        scheduleObject.order = self.order
        return scheduleObject
    }
}
