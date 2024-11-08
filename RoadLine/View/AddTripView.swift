//
//  AddTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/8/24.
//

import SwiftUI

struct AddTripView: View {
    @Environment(\.dismiss) var dismiss // sheet를 닫기 위한 dismiss 환경 변수
    
    // struct Travel: Codable {
    //     let country: String                 // 여행 국가
    //     let cities: [String]                // 여행 도시 배열
    //     let departureDate: Date             // 출발 날짜
    //     let returnDate: Date                // 귀국 날짜
    //     let notes: String                   // 메모
    //     let currency: String                // 통화
    
    @State private var country: String = ""
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var notes: String = ""
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 40) {
                    VStack(spacing: 10) {
                        Text("1. 어디로 떠나시나요?")
                            .font(.title3)
                            .bold()
                            .italic()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.primary)
                        
                        TextField("여행 국가", text: $country) // 일정 이름 입력
                            .frame(height: 44)
                            .multilineTextAlignment(.leading)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundStyle(Color.primary)
                        
                    }
                    .padding(.horizontal, 24)
                    
                    VStack(spacing: 18) {
                        Text("2. 얼마나 여행하시나요?")
                            .font(.title3)
                            .bold()
                            .italic()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.primary)
                        
                        CalendarView(startDate: $startDate, endDate: $endDate)
                        
                        if let startDate = startDate, let endDate = endDate {
                            Text("\(formattedDate(startDate))   -   \(formattedDate(endDate))")
                                .frame(width: 340, height: 40)
                                .background(Color.accentColor)
                                .cornerRadius(20)
                                .foregroundStyle(.white)
                            
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    VStack(spacing: 10) {
                        Text("3. 누구와 함께하시나요?")
                            .font(.title3)
                            .bold()
                            .italic()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.primary)
                        
                        TextField("엄마와 떠나는 가을 여행", text: $notes) // 일정 이름 입력
                            .frame(height: 44)
                            .multilineTextAlignment(.leading)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundStyle(Color.primary)
                        
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.vertical)
                
            }
            
            .navigationTitle("여행 일정 만들기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        // 저장 작업 수행
                        dismiss()
                    }
                    .foregroundStyle(Color.accentColor)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                    .foregroundStyle(Color.accentColor)
                }
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
}

#Preview {
    AddTripView()
}


