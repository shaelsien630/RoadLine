//
//  RealmManager.swift
//  RoadLine
//
//  Created by 최서희 on 11/12/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    // 여행 목록 조회 (각 여행의 일정도 포함하여 반환)
    func fetchAllTravels() async -> [Travel] {
        return await Task {
            let realm = try! Realm()
            let objects = realm.objects(TravelObject.self)
            return objects.map { Travel(from: $0) } // Travel 모델로 변환
        }.value
    }
    
    // 여행 추가
    func addTravel(
        country: String,
        departureDate: Date,
        returnDate: Date,
        notes: String,
        currency: String
    ) async throws {
        try await Task {
            let realm = try! Realm()
            
            // 새 여행 객체 생성 및 추가
            let newTravel = TravelObject()
            newTravel.country = country
            newTravel.departureDate = departureDate
            newTravel.returnDate = returnDate
            newTravel.notes = notes
            newTravel.currency = currency
            
            try realm.write {
                realm.add(newTravel)
            }
        }.value
    }
    
    // 여행 삭제 (연관된 일정도 함께 삭제)
    func deleteTravel(by id: ObjectId) async throws {
        try await Task {
            let realm = try! Realm()
            
            guard let travel = realm.object(ofType: TravelObject.self, forPrimaryKey: id) else {
                throw NSError(domain: "RealmManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "해당 여행 데이터를 찾을 수 없습니다."])
            }
            
            try realm.write {
                realm.delete(travel.schedules) // 여행에 포함된 일정 먼저 삭제
                realm.delete(travel) // 여행 삭제
            }
        }.value
    }
    
    // 특정 여행(Travel)에 속한 일정 조회 (order 순서 적용 + 시간 정렬)
    /// 모든 날짜 일정 조회(ALL) : let allSchedules = await realmManager.fetchSchedules(for: parisId)
    /// 특정 날짜 일정 조회 : let secondDaySchedules = await realmManager.fetchSchedules(for: parisId, on: 1)
    func fetchSchedules(for travelId: ObjectId, on date: Date? = nil) async -> [Schedule] {
        return await Task {
            let realm = try! Realm()
            
            // Realm에서 데이터를 불러올 때 기본 필터 적용
            var objects = realm.objects(ScheduleObject.self)
                .filter("travelId == %@", travelId)
            
            // 특정 날짜(date) 일정만 필터링
            if let date = date {
                objects = objects.filter("date == %@", date)
            }

            // Realm의 Results를 Array로 변환 후 정렬
            let sortedSchedules = objects.map { $0 }.sorted {
                if $0.date != $1.date {
                    return $0.date < $1.date
                }
                
                return $0.order < $1.order // 같은 날짜 내에서는 order 기준으로 정렬
            }

            return sortedSchedules.map { Schedule(from: $0) }
        }.value
    }

    // 일정 추가 (특정 여행 ID, 특정 날짜, 시간 포함 가능)
    func addSchedule(
        travelId: ObjectId,
        date: Date,
        title: String,
        location: String,
        time: String,
        notes: String
    ) async throws {
        try await Task {
            let realm = try! Realm()
            
            guard let travelObject = realm.object(ofType: TravelObject.self, forPrimaryKey: travelId) else {
                throw NSError(domain: "RealmManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "해당 여행 데이터를 찾을 수 없습니다."])
            }
            
            // 현재 여행 및 해당 날짜의 일정 개수 조회하여 order 값 설정
            let currentSchedules = realm.objects(ScheduleObject.self)
                .filter("travelId == %@ AND date == %@", travelId, date)
            
            let newOrder = (currentSchedules.last?.order ?? 0) + 1

            // 새 일정 객체 생성
            let newSchedule = ScheduleObject()
            newSchedule.travelId = travelId
            newSchedule.date = date
            newSchedule.title = title
            newSchedule.location = location
            newSchedule.time = time
            newSchedule.notes = notes
            newSchedule.order = newOrder // 마지막 순서로 추가

            try realm.write {
                realm.add(newSchedule)
                travelObject.schedules.append(newSchedule) // ✅ TravelObject에도 추가
            }
        }.value
    }

    // 특정 일정 개별 삭제
    func deleteSchedule(by id: ObjectId) async throws {
        try await Task {
            let realm = try! Realm()
            
            guard let schedule = realm.object(ofType: ScheduleObject.self, forPrimaryKey: id) else {
                throw NSError(domain: "RealmManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "해당 일정을 찾을 수 없습니다."])
            }
            
            try realm.write {
                realm.delete(schedule) // 해당 일정 삭제
            }
        }.value
    }

    // 특정 여행의 모든 일정 삭제
    func deleteSchedules(for travelId: ObjectId) async throws {
        try await Task {
            let realm = try! Realm()
            let schedules = realm.objects(ScheduleObject.self).filter("travelId == %@", travelId)

            try realm.write {
                realm.delete(schedules) // 특정 여행의 모든 일정 삭제
            }
        }.value
    }

    // 일정 순서 변경 (드래그 앤 드롭 등에서 활용)
    func updateScheduleOrder(for travelId: ObjectId, schedules: [Schedule]) async throws {
        try await Task {
            let realm = try! Realm()
            
            try realm.write {
                for (index, schedule) in schedules.enumerated() {
                    if let scheduleObject = realm.object(ofType: ScheduleObject.self, forPrimaryKey: schedule.id) {
                        scheduleObject.order = index // 새로운 순서 적용
                    }
                }
            }
        }.value
    }
}
