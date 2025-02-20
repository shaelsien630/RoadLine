//
//  ScheduleRepository.swift
//  RoadLine
//
//  Created by 최서희 on 2/19/25.
//

import Foundation
import RealmSwift
import ComposableArchitecture

final class ScheduleRepository {
    private let realmManager = RealmManager()
    
    // 특정 여행의 특정 날짜(index) 일정 조회
    func fetchSchedules(for travelId: ObjectId, on date: Date?) async -> [Schedule] {
        return await realmManager.fetchSchedules(for: travelId, on: date)
    }

    // 특정 여행의 특정 날짜(index)에 일정 추가
    func addSchedule(
        travelId: ObjectId,
        date: Date,
        title: String,
        location: String,
        time: String,
        notes: String
    ) async throws {
        try await realmManager.addSchedule(
            travelId: travelId,
            date: date,
            title: title,
            location: location,
            time: time,
            notes: notes
        )
    }

    // 특정 일정 삭제
    func deleteSchedule(by id: ObjectId) async throws {
        try await realmManager.deleteSchedule(by: id)
    }

    // 특정 여행의 모든 일정 삭제
    func deleteSchedules(for travelId: ObjectId) async throws {
        try await realmManager.deleteSchedules(for: travelId)
    }

    // 일정 순서 변경
    func updateScheduleOrder(for travelId: ObjectId, schedules: [Schedule]) async throws {
        try await realmManager.updateScheduleOrder(for: travelId, schedules: schedules)
    }
}
