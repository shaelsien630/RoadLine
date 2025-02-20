//
//  Dependency+Extensions.swift
//  RoadLine
//
//  Created by 최서희 on 2/20/25.
//

import ComposableArchitecture

// DependencyValues 확장 (의존성 등록)
extension DependencyValues {
    var travelRepository: TravelRepository {
        get { self[TravelRepositoryKey.self] }
        set { self[TravelRepositoryKey.self] = newValue }
    }

    var scheduleRepository: ScheduleRepository {
        get { self[ScheduleRepositoryKey.self] }
        set { self[ScheduleRepositoryKey.self] = newValue }
    }
}

// 여행 저장소 키
private enum TravelRepositoryKey: DependencyKey {
    static let liveValue = TravelRepository()
}

// 일정 저장소 키
private enum ScheduleRepositoryKey: DependencyKey {
    static let liveValue = ScheduleRepository()
}
