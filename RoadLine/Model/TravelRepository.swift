//
//  TravelRepository.swift
//  RoadLine
//
//  Created by 최서희 on 11/12/24.
//

import Foundation
import Combine
import RealmSwift

final class TravelRepository {
    private let dataSource = RealmDataSource()
    
    func fetchAllTravels() -> [Travel] {
        return dataSource.fetchAllTravels()
    }
    
    func fetchComingTravels() -> Results<Travel> {
        return dataSource.fetchComingTravels()
    }
    
    func fetchPastTravels() -> Results<Travel> {
        return dataSource.fetchPastTravels()
    }
    
    func getTravel(by id: ObjectId) -> Travel? {
        return dataSource.getTravel(by: id)
    }
    
    func addTravel(country: String, departureDate: Date, returnDate: Date, notes: String, currency: String) {
        let travel = Travel()
        travel.country = country
        travel.departureDate = departureDate
        travel.returnDate = returnDate
        travel.notes = notes
        travel.currency = currency
        dataSource.addTravel(travel)
    }
    
    func deleteTravel(by id: ObjectId) {
        dataSource.deleteTravel(by: id)
    }
}
