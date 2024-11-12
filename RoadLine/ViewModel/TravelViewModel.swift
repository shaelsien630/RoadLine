//
//  TravelViewModel.swift
//  RoadLine
//
//  Created by 최서희 on 11/11/24.
//

import Foundation
import Combine
import RealmSwift

class TravelViewModel: ObservableObject {
    private let repository = TravelRepository()
    @Published var travels: [Travel] = []
    
    @Published var comingTravels: Results<Travel>
    @Published var pastTravels: Results<Travel>
    
    init() {
        comingTravels = repository.fetchComingTravels()
        pastTravels = repository.fetchPastTravels()
    }
    
    func fetchItems() {
        travels = repository.fetchAllTravels()
    }
    
    func getTravel(by id: ObjectId) -> Travel? {
        return repository.getTravel(by: id)
    }
    
    func addTravel(country: String, departureDate: Date, returnDate: Date, notes: String) {
        repository.addTravel(country: country, departureDate: departureDate, returnDate: returnDate, notes: notes, currency: "KRW")
        fetchItems()
    }
    
    func deleteTravel(by id: ObjectId) {
        repository.deleteTravel(by: id)
        fetchItems()
    }
}
