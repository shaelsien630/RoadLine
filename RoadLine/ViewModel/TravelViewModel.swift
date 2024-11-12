//
//  TravelViewModel.swift
//  RoadLine
//
//  Created by 최서희 on 11/11/24.
//

import Foundation
import RealmSwift
import Combine

class TravelViewModel: ObservableObject {
    private var realm: Realm
    @Published var travels: [Travel] = []  // 목록을 뷰에 바인딩
    
    init() {
        // Realm 초기화 및 데이터 로드
        realm = try! Realm()
        fetchItems()
    }
    
    // Realm에서 모든 항목 가져오기
    func fetchItems() {
        let results = realm.objects(Travel.self)
        
        // 쓰기 트랜잭션에서 각 항목의 `isComming` 업데이트
        try! realm.write {
            for travel in results {
                travel.isComming = travel.returnDate > Date()  // 현재 날짜와 비교하여 업데이트
            }
        }
        
        travels = Array(results)
    }
    
    // 새로운 여행 추가
    func addTravel(country: String, departureDate: Date, returnDate: Date, notes: String) {
        let travel = Travel()
        travel.country = country
        travel.departureDate = departureDate
        travel.returnDate = returnDate
        travel.notes = notes
        travel.currency = "KRW"
        
        try! realm.write {
            realm.add(travel)
        }
        
        fetchItems()
    }
    
    // ObjectId로 Travel 객체 찾기
    func getTravel(by id: ObjectId) -> Travel? {
        return realm.object(ofType: Travel.self, forPrimaryKey: id)
    }
    
    // MARK - TODO - 여행 updqte
    
    // 여행 삭제
    func removeTravel(by id: ObjectId) {
        if let travel = getTravel(by: id) {
            try! realm.write {
                realm.delete(travel)
            }
            fetchItems()
        }
    }
}

// class TravelViewModel: ObservableObject {
//     @Published var travels: [Travel] = []
//     @Published var commingTravels: [String] = []
//     @Published var pastTravels: [String] = []
//     
//     init() {
//         loadData()
//     }
//     
//     // MARK: - Sample Data
//     
//     private func loadData() {
//         // 예제 데이터 추가 (실제 앱에서는 서버에서 데이터를 가져오거나, 로컬 저장소에서 불러오는 로직이 들어갈 수 있습니다)
//         // DB데이터 파싱 후 comming, past로 나누어 id 저장하기
//         let sampleTravel = Travel(
//             id: "0",
//             country: "일본 도쿄",
//             departureDate: Date(),
//             returnDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
//             notes: "가을 여행",
//             currency: "JPY",
//             schedules: [
//                 Schedule(day: 1, locations: [
//                     Location(name: "도쿄타워", coordinates: "35.6586,139.7454", time: "10:00 AM", notes: "전망대에서 도쿄 시내 감상"),
//                     Location(name: "스카이트리", coordinates: "35.7100,139.8107", time: "2:00 PM", notes: "도쿄 최고의 랜드마크")
//                 ])
//             ],
//             expenses: [
//                 Expense(date: Date(), imageURL: "", amount: 10000, amountInKRW: 95000, category: "식비", notes: "초밥 식사")
//             ]
//         )
//         travels.append(sampleTravel)
//     }
//     
//     // MARK: - CRUD Operations
//     
//     // 새로운 여행 추가
//     func addTravel(country: String, departureDate: Date, returnDate: Date, notes: String) {
//         let travel = Travel(
//             id: UUID().uuidString,
//             country: country,
//             departureDate: departureDate,
//             returnDate: returnDate,
//             notes: notes,
//             currency: "KRW",
//             schedules: [],
//             expenses: []
//         )
//         if returnDate > Date() {
//             commingTravels.append(travel.id)
//         } else {
//             pastTravels.append(travel.id)
//         }
// 
//         travels.append(travel)
//     }
//     
//     // 여행 삭제
//     func removeTravel(id: String) {
//         travels.removeAll { $0.id == id }
//     }
//     
//     // 여행 업데이트
//     func updateTravel(id: String, updatedTravel: Travel) {
//         if let index = travels.firstIndex(where: { $0.id == id }) {
//             travels[index] = updatedTravel
//         }
//     }
//     
//     // 특정 여행 정보 가져오기
//     func getTravel(by id: String) -> Travel? {
//         return travels.first { $0.id == id }
//     }
//     
//     // 특정 여행의 일정 가져오기
//     func getSchedules(for travelId: String) -> [Schedule]? {
//         return travels.first(where: { $0.id == travelId })?.schedules
//     }
//     
//     // 특정 여행의 가계부 정보 가져오기
//     func getExpenses(for travelId: String) -> [Expense]? {
//         return travels.first(where: { $0.id == travelId })?.expenses
//     }
// }
