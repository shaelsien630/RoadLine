//
//  AddTravel.swift
//  RoadLine
//
//  Created by 최서희 on 11/8/24.
//

import SwiftUI
import ComposableArchitecture

struct AddTravel: View {
    let store: StoreOf<TravelFeature>
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    
    @State private var showAlert: AlertType?
    @State private var country: String = ""
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var notes: String = ""
    
    // Alert 종류를 관리하는 Enum
    enum AlertType: Identifiable {
        case country, date, notes
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 40) {
                    countryInputSection
                    dateInputSection
                    notesInputSection
                }
                .padding(.vertical)
            }
            .navigationTitle("여행 만들기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture().onEnded { isFocused = false }
            )
            .alert(item: $showAlert) { alertType in
                switch alertType {
                case .country:
                    return Alert(title: Text("여행 장소를 입력해주세요"), dismissButton: .default(Text("확인")))
                case .date:
                    return Alert(title: Text("여행 날짜를 선택해주세요"), dismissButton: .default(Text("확인")))
                case .notes:
                    return Alert(title: Text("여행 메모를 입력해주세요"), dismissButton: .default(Text("확인")))
                }
            }
        }
    }
}

// MARK: - UI Components
extension AddTravel {
    // 여행지 입력 UI
    var countryInputSection: some View {
        VStack(spacing: 10) {
            Text("1. 어디로 떠나시나요?")
                .font(.title3)
                .bold()
                .italic()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
            
            TextField("일본 도쿄", text: $country)
                .focused($isFocused)
                .frame(height: 44)
                .multilineTextAlignment(.leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 24)
    }
    
    // 날짜 선택 UI
    var dateInputSection: some View {
        VStack(spacing: 18) {
            Text("2. 얼마나 여행하시나요?")
                .font(.title3)
                .bold()
                .italic()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
            
            // CalendarView는 시작일과 종료일을 선택하는 커스텀 뷰
            CalendarView(startDate: $startDate, endDate: $endDate)
            
            if let startDate = startDate, let endDate = endDate {
                Text("\(startDate.dateToString(format: .yyyyMMdd))   -   \(endDate.dateToString(format: .yyyyMMdd))")
                    .frame(width: 340, height: 40)
                    .background(Color.accentColor)
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // 여행 메모 입력 UI
    var notesInputSection: some View {
        VStack(spacing: 10) {
            Text("3. 누구와 함께하시나요?")
                .font(.title3)
                .bold()
                .italic()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)
            
            TextField("엄마와 떠나는 가을 여행", text: $notes)
                .focused($isFocused)
                .frame(height: 44)
                .multilineTextAlignment(.leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 24)
    }
    
    // 툴바 (네비게이션 바 버튼)
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("저장") { saveTravel() }
                .foregroundColor(Color.accentColor)
        }
        ToolbarItem(placement: .cancellationAction) {
            Button("취소") { dismiss() }
                .foregroundColor(Color.accentColor)
        }
    }
}

// MARK: - Actions
extension AddTravel {
    private func saveTravel() {
        if country.isEmpty {
            showAlert = .country
        } else if notes.isEmpty {
            showAlert = .notes
        } else if let startDate = startDate, let endDate = endDate {
            store.send(.addTravel(
                country: country,
                departureDate: startDate,
                returnDate: endDate,
                notes: notes,
                currency: "KRW" // 기본 통화값
            ))
            dismiss()
        } else {
            showAlert = .date
        }
    }
}

// MARK: - Preview
#Preview {
    AddTravel(
        store: Store(
            initialState: TravelFeature.State(),
            reducer: { TravelFeature() }
        )
    )
}
