//
//  Itinerary.swift
//  RoadLine
//
//  Created by 최서희 on 11/11/24.
//

import SwiftUI
import ComposableArchitecture

enum ItineraryTabType: String, CaseIterable {
    case list = "list.bullet"
    case map = "map"
}

struct Itinerary: View {
    let travel: Travel
    let store: StoreOf<ScheduleFeature>
    let dates: [Date]
    
    @State private var selectedDate: Date?
    @State private var selectedTab: ItineraryTabType = .list
    @State private var showSheet: Bool = false
    @Namespace private var animation
    
    init(travel: Travel) {
        self.travel = travel
        self.store = Store(
            initialState: ScheduleFeature.State(travelId: travel.id),
            reducer: { ScheduleFeature() }
        )
        // 여행의 날짜 범위 생성 (출발일 ~ 도착일)
        self.dates = Itinerary.generateDateRange(from: travel.departureDate, to: travel.returnDate)
        
        // 오늘 날짜의 startOfDay 값
        let today = Calendar.current.startOfDay(for: Date())
        // 생성된 날짜 목록에서 오늘과 같은 날짜(시간은 00:00:00) 찾기
        let foundDate = self.dates.first(where: {
            Calendar.current.isDate(Calendar.current.startOfDay(for: $0), inSameDayAs: today)
        }) ?? self.dates.first
        
        // 초기 selectedDate 설정 (nil이 아니도록)
        self._selectedDate = State(initialValue: foundDate)

    }
    
    var body: some View {
        VStack(spacing: 0) {
            ItineraryDate(dates: dates, selectedDate: $selectedDate)
            ItineraryTabSelector()
            
            ZStack(alignment: .bottom) {
                if selectedTab == .list {
                    ScheduleList(store: store, schedules: travel.schedules)
                        .transition(.opacity)
                } else {
                    ScheduleMap(store: store, schedules: travel.schedules)
                        .transition(.opacity)
                }
                
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 50, height: 50)
                                .shadow(color: Color.accentColor.opacity(0.3), radius: 10, x: 0, y: 5)
                        )
                }
                .offset(y: -20)
                .zIndex(1)
            }
            .animation(.easeInOut(duration: 0.3), value: selectedTab)
        }
        .sheet(isPresented: $showSheet) {
            if let date = selectedDate {
                AddSchedule(store: store, travelId: travel.id, date: date)
            }
        }
        .onAppear {
            if let date = selectedDate {
                store.send(.fetchSchedules(travelId: travel.id, date: date))
            }
        }
    }
    
    @ViewBuilder
    private func ItineraryTabSelector() -> some View {
        HStack(spacing: 0) {
            ForEach(ItineraryTabType.allCases, id: \.self) { item in
                VStack(spacing: 0) {
                    Image(systemName: item.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 20)
                        .foregroundColor(selectedTab == item ? .white : .secondary)
                        .padding(11)
                        .frame(maxWidth: .infinity)
                    
                    if selectedTab == item {
                        Capsule()
                            .foregroundColor(.white)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "tab", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        self.selectedTab = item
                    }
                }
            }
        }
        .frame(height: 44)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.cyan, Color.accentColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
        .padding(.top, 16)
    }
    
    
    // 출발일부터 도착일까지의 날짜 리스트 생성
    static func generateDateRange(from startDate: Date, to endDate: Date) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            guard let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }
        return dates
    }
}
