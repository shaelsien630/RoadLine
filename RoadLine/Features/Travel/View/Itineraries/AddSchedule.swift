//
//  AddSchedule.swift
//  RoadLine
//
//  Created by 최서희 on 2/19/25.
//

import SwiftUI
import ComposableArchitecture
import RealmSwift

struct AddSchedule: View {
    let store: StoreOf<ScheduleFeature>
    let travelId: ObjectId
    let date: Date
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 40) {
                    Text("지도 보여주세욧")
                }
                .padding(.vertical)
            }
            .navigationTitle("여행 일정 만들기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
            .contentShape(Rectangle())
        }
    }
    
    // 툴바 (네비게이션 바 버튼)
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("저장") { saveSchedule() }
                .foregroundColor(Color.accentColor)
        }
        ToolbarItem(placement: .cancellationAction) {
            Button("취소") { dismiss() }
                .foregroundColor(Color.accentColor)
        }
    }
}

// MARK: - Actions
extension AddSchedule {
    private func saveSchedule() {
        store.send(.addSchedule(
            travelId: travelId,
            date: date,
            title: "하네다 공항",
            location: "하네다 공항 위치정보",
            time: "13:00",
            notes: "환전해야함")
        )
        dismiss()
    }
}

#Preview {
    // AddSchedule(
    //     store: Store(
    //         initialState: TravelFeature.State(),
    //         reducer: { TravelFeature() }
    //     )
    // )
}
