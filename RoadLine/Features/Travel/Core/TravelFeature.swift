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
    @ObservableState
    struct State: Equatable {
        var allTravels: [Travel] = []
        var comingTravels: [Travel] = []
        var pastTravels: [Travel] = []
        var errorMessage: String? // 에러 메시지 추가
    }
    
    enum Action {
        case fetchAllTravels
        case fetchAllTravelsResponse(Result<[Travel], Error>)
        
        case addTravel(country: String, departureDate: Date, returnDate: Date, notes: String, currency: String)
        case addTravelResponse(Result<Void, Error>)
        
        case deleteTravel(id: ObjectId)
        case deleteTravelResponse(Result<Void, Error>)

        case showError(String)
    }
    
    @Dependency(\.travelRepository) var travelRepository
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchAllTravels:
            return .run { send in
                do {
                    let travels = try await travelRepository.fetchAllTravels()
                    await send(.fetchAllTravelsResponse(.success(travels)))
                } catch {
                    await send(.fetchAllTravelsResponse(.failure(error)))
                }
            }
            
        case let .fetchAllTravelsResponse(result):
            switch result {
            case let .success(travels):
                state.allTravels = travels
                state.comingTravels = travels.filter { $0.returnDate > Date() }
                    .sorted { $0.departureDate < $1.departureDate }
                state.pastTravels = travels.filter { $0.returnDate < Date() }
                    .sorted { $0.departureDate > $1.departureDate }
            case .failure(let error):
                state.errorMessage = "여행 목록을 불러오는데 실패했습니다: \(error.localizedDescription)"
            }
            return .none
            
        case let .addTravel(country, departureDate, returnDate, notes, currency):
            return .run { send in
                do {
                    try await travelRepository.addTravel(
                        country: country,
                        departureDate: departureDate,
                        returnDate: returnDate,
                        notes: notes,
                        currency: currency
                    )
                    await send(.addTravelResponse(.success(())))
                } catch {
                    await send(.addTravelResponse(.failure(error)))
                }
            }
            
        case let .addTravelResponse(result):
            switch result {
            case .success:
                return .run { send in
                    await send(.fetchAllTravels)
                }
            case .failure(let error):
                state.errorMessage = "여행 추가에 실패했습니다: \(error.localizedDescription)"
                return .none
            }
            
        case let .deleteTravel(id):
            return .run { send in
                do {
                    try await travelRepository.deleteTravel(by: id)
                    await send(.deleteTravelResponse(.success(())))
                } catch {
                    await send(.deleteTravelResponse(.failure(error)))
                }
            }
            
        case let .deleteTravelResponse(result):
            switch result {
            case .success:
                return .run { send in
                    await send(.fetchAllTravels)
                }
            case .failure(let error):
                state.errorMessage = "여행 삭제에 실패했습니다: \(error.localizedDescription)"
                return .none
            }

        case let .showError(message):
            state.errorMessage = message
            return .none
        }
    }
}
