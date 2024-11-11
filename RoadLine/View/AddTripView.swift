//
//  AddTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/8/24.
//

import SwiftUI

struct AddTripView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlertCountry: Bool = false
    @State private var showAlertDate: Bool = false
    @State private var showAlertNotes: Bool = false
    
    @State private var country: String = ""
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var notes: String = ""
    
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
                        
                        TextField("일본 도쿄", text: $country)
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
                            Text("\(startDate.dateToString(format: .yyyyMMdd))   -   \(endDate.dateToString(format: .yyyyMMdd))")
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
                        if country.isEmpty {
                            showAlertCountry = true
                        } else if notes.isEmpty  {
                            showAlertNotes = true
                        } else {
                                if let startDate = startDate,
                                   let endDate = endDate {
                                    travelViewModel.addTravel(
                                        country: country,
                                        departureDate: startDate,
                                        returnDate: endDate,
                                        notes: notes
                                    )
                                    dismiss()
                                } else {
                                    showAlertDate = true
                                }
                        }
                    }
                    .alert("여행 장소를 입력해주세요", isPresented: $showAlertCountry) {
                        Button("확인", role: .cancel) { }
                    }
                    .alert("여행 날짜를 선택해주세요", isPresented: $showAlertDate) {
                        Button("확인", role: .cancel) { }
                    }
                    .alert("여행 메모를 입력해주세요", isPresented: $showAlertNotes) {
                        Button("확인", role: .cancel) { }
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
}

#Preview {
    AddTripView()
}


