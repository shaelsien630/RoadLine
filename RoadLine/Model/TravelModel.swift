//
//  TravelModel.swift
//  RoadLine
//
//  Created by 최서희 on 11/8/24.
//

import Foundation
import RealmSwift

// Realm 모델
class Travel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()  // 고유 ID
    @Persisted var country: String = ""
    @Persisted var departureDate: Date = Date()
    @Persisted var returnDate: Date = Date()
    @Persisted var notes: String = ""
    @Persisted var currency: String = ""
    @Persisted var isComming: Bool = false
    // @objc dynamic var schedules: [Schedule]
    // @objc dynamic var expenses: [Expense]
}

// // 여행 정보 구조체
// struct Travel: Identifiable, Codable {
//     let id: String
//     let country: String                 // 여행 국가
//     let departureDate: Date             // 출발 날짜
//     let returnDate: Date                // 귀국 날짜
//     let notes: String                   // 메모
//     let currency: String                // 통화
//     let schedules: [Schedule]           // 일정 배열
//     let expenses: [Expense]             // 가계부 배열
// }
// 
// // 일정 정보 구조체
// struct Schedule: Codable {
//     let day: Int                        // 여행일 (첫째 날, 둘째 날 등)
//     let locations: [Location]           // 장소 배열
// }
// 
// // 장소 정보 구조체
// struct Location: Codable {
//     let name: String                    // 장소명
//     let coordinates: String             // 위치 (위도, 경도 등 위치 정보)
//     let time: String                    // 방문 시간
//     let notes: String                   // 메모
// }
// 
// // 가계부 정보 구조체
// struct Expense: Codable {
//     let date: Date                      // 날짜
//     let imageURL: String                // 이미지 URL
//     let amount: Double                  // 금액
//     let amountInKRW: Double             // 원화 금액
//     let category: String                // 카테고리
//     let notes: String                   // 메모
// }
