//
//  ScheduleFeature.swift
//  RoadLine
//
//  Created by 최서희 on 2/19/25.
//

import Foundation
import ComposableArchitecture
import RealmSwift

// MARK: - TCA 도메인
@Reducer
struct ScheduleFeature {
    @ObservableState
    struct State: Equatable {
        var schedules: [Schedule] = []
        var errorMessage: String?
        var travelId: ObjectId? // 여행 ID 저장
        // @BindingState var selectedDate: Date = Date() // 선택한 날짜 (기본 오늘)
    }
    
    enum Action {
        case fetchSchedules(travelId: ObjectId, date: Date?)
        case fetchSchedulesResponse(Result<[Schedule], Error>)
        
        case addSchedule(travelId: ObjectId, date: Date, title: String, location: String, time: String, notes: String)
        case addScheduleResponse(Result<Date, Error>)
        
        case deleteSchedule(id: ObjectId, date: Date)
        case deleteScheduleResponse(Result<Date, Error>)
        
        case updateScheduleOrder(travelId: ObjectId, schedules: [Schedule], date: Date)
        case updateScheduleOrderResponse(Result<Date, Error>)
        
        case showError(String)
    }
    
    @Dependency(\.scheduleRepository) var scheduleRepository
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .fetchSchedules(travelId, date):
            return .run { send in
                do {
                    let schedules = await scheduleRepository.fetchSchedules(for: travelId, on: date)
                    print(schedules.count)
                    await send(.fetchSchedulesResponse(.success(schedules)))
                } catch {
                    await send(.fetchSchedulesResponse(.failure(error)))
                }
            }
            
        case let .fetchSchedulesResponse(result):
            switch result {
            case let .success(schedules):
                state.schedules = schedules
            case .failure(let error):
                state.errorMessage = "일정을 불러오는데 실패했습니다: \(error.localizedDescription)"
            }
            return .none
            
        case let .addSchedule(travelId, date, title, location, time, notes):
            return .run { send in
                do {
                    try await scheduleRepository.addSchedule(
                        travelId: travelId,
                        date: date,
                        title: title,
                        location: location,
                        time: time,
                        notes: notes
                    )
                    await send(.addScheduleResponse(.success(date))) // ✅ 성공 시 추가한 일정의 날짜 전달
                } catch {
                    await send(.addScheduleResponse(.failure(error)))
                }
            }

        case let .addScheduleResponse(result):
            switch result {
            case let .success(date): // ✅ date를 받아서 해당 날짜의 일정 새로 불러오기
                if let travelId = state.travelId {
                    return .run { send in
                        await send(.fetchSchedules(travelId: travelId, date: date)) // ✅ 해당 날짜 일정만 새로 불러오기
                    }
                }
            case .failure(let error):
                state.errorMessage = "일정 추가에 실패했습니다: \(error.localizedDescription)"
            }
            return .none
            
        case let .deleteSchedule(id, date):
            return .run { send in
                do {
                    try await scheduleRepository.deleteSchedule(by: id)
                    await send(.deleteScheduleResponse(.success(date)))
                } catch {
                    await send(.deleteScheduleResponse(.failure(error)))
                }
            }
            
        case let .deleteScheduleResponse(result):
            switch result {
            case let .success(date):
                if let travelId = state.travelId {
                    return .run { send in
                        await send(.fetchSchedules(travelId: travelId, date: date))
                    }
                }
            case .failure(let error):
                state.errorMessage = "일정 삭제에 실패했습니다: \(error.localizedDescription)"
            }
            return .none
            
        case let .updateScheduleOrder(travelId, schedules, date):
            return .run { send in
                do {
                    try await scheduleRepository.updateScheduleOrder(for: travelId, schedules: schedules)
                    await send(.updateScheduleOrderResponse(.success(date)))
                } catch {
                    await send(.updateScheduleOrderResponse(.failure(error)))
                }
            }
            
        case let .updateScheduleOrderResponse(result):
            switch result {
            case let .success(date):
                if let travelId = state.travelId {
                    return .run { send in
                        await send(.fetchSchedules(travelId: travelId, date: date))
                    }
                }
            case .failure(let error):
                state.errorMessage = "일정 순서 업데이트에 실패했습니다: \(error.localizedDescription)"
            }
            return .none
            
        case let .showError(message):
            state.errorMessage = message
            return .none
        }
    }
}
