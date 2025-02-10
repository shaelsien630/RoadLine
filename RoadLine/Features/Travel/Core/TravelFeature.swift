//
//  TravelFeature.swift
//  RoadLine
//
//  Created by 최서희 on 2/10/25.
//

//
//  TravelCore.swift
//  RoadLine
//
//  Created by 최서희 on 2/10/25.
//

import Foundation
import ComposableArchitecture
import RealmSwift
import Combine

// MARK: - TCA 도메인

@Reducer
struct TravelFeature {
    // MARK: - State
    /// 여행 데이터와 로딩 상태 관리
    @ObservableState
    struct State: Equatable {
        var allTravels: [Travel] = []
        var comingTravels: [Travel] = []
        var pastTravels: [Travel] = []
    }
    
    // MARK: - Action
    /// 여행 목록 조회, 추가, 삭제 등의 이벤트 정의
    enum Action {
        // 여행 조회 요청 및 응답
        case fetchAllTravels
        case fetchAllTravelsResponse(Result<[Travel], Error>)
        
        // 여행 추가 요청 및 응답
        case addTravel(country: String, departureDate: Date, returnDate: Date, notes: String, currency: String)
        case addTravelResponse(Result<Void, Error>)
        
        // 여행 삭제 요청 및 응답
        case deleteTravel(id: ObjectId)
        case deleteTravelResponse(Result<Void, Error>)
    }
    
    // TCA 의존성
    @Dependency(\.travelRepository) var travelRepository
    
    // MARK: - Reducer
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchAllTravels: // 전체 여행 목록 조회
            return .run { send in
                let travels = await travelRepository.fetchAllTravels()
                await send(.fetchAllTravelsResponse(.success(travels)))
            }
            
        case let .fetchAllTravelsResponse(result):
            switch result {
            case let .success(travels):
                state.allTravels = travels
                state.comingTravels = travels.filter { $0.returnDate > Date() }
                    .sorted { $0.departureDate < $1.departureDate }
                state.pastTravels = travels.filter { $0.returnDate < Date() }
                    .sorted { $0.departureDate > $1.departureDate }
            case .failure:
                state.allTravels = []
            }
            return .none
            
        case let .addTravel(country, departureDate, returnDate, notes, currency): // 여행 추가
            return .run { send in
                await travelRepository.addTravel(
                    country: country,
                    departureDate: departureDate,
                    returnDate: returnDate,
                    notes: notes,
                    currency: currency
                )
                await send(.addTravelResponse(.success(())))
            }
            
        case let .addTravelResponse(result):
            switch result {
            case .success:
                // 여행 추가 후 최신 데이터를 반영하기 위해 전체 여행 목록 재조회
                return .run { send in
                    await send(.fetchAllTravels)
                }
            case .failure:
                return .none
            }
            
            
        case let .deleteTravel(id): // 여행 삭제
            return .run { send in
                await travelRepository.deleteTravel(by: id)
                await send(.deleteTravelResponse(.success(())))
            }
            
        case let .deleteTravelResponse(result):
            switch result {
            case .success:
                // 삭제 후 최신 데이터를 반영하기 위해 전체 여행 목록 재조회
                return .run { send in
                    await send(.fetchAllTravels)
                }
            case .failure:
                return .none
            }
        }
    }
}
