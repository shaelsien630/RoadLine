//
//  CalendarView.swift
//  RoadLine
//
//  Created by 최서희 on 11/8/24.
//

import SwiftUI

struct CalendarView: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @State private var displayedMonth: Date = Date()  // 현재 표시 중인 달
    private let calendar = Calendar.current

    var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 50) {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.accentColor)
                }

                Text(monthAndYear(for: displayedMonth))
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundStyle(Color.primary)

                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.accentColor)
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { day in
                    if day == "일" {
                        Text(day)
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.red)
                    } else {
                        Text(day)
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.primary)
                    }
                }

                ForEach(daysInMonth().indices, id: \.self) { index in
                    if let date = daysInMonth()[index] {
                        ZStack {
                            if let startDate = startDate, let endDate = endDate {
                                if date > startDate && date < endDate {
                                    Rectangle()
                                        .fill(Color.accentColor.opacity(0.2))
                                        .padding(.horizontal, -4)
                                } else if date == startDate {
                                    Rectangle()
                                        .fill(Color.accentColor.opacity(0.2))
                                        .padding(.leading, 20)
                                        .padding(.trailing, -4)
                                } else if date == endDate {
                                    Rectangle()
                                        .fill(Color.accentColor.opacity(0.2))
                                        .padding(.leading, -4)
                                        .padding(.trailing, 20)
                                }
                            }
                            
                            Text("\(calendar.component(.day, from: date))")
                                .frame(width: 40, height: 40)
                                .background(circleBackground(date: date))
                                .clipShape(Circle())
                                .foregroundColor(textColor(for: date))
                                .onTapGesture {
                                    handleDateSelection(date: date)
                                }
                        }
                    } else {
                        Text("")
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .padding(.top)
    }

    // 월 변경
    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
            displayedMonth = newMonth
        }
    }

    // 월과 연도 포맷
    private func monthAndYear(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: date)
    }

    // 현재 표시 중인 달의 모든 날짜 가져오기 (첫 번째 날의 요일에 맞게 조정)
    private func daysInMonth() -> [Date?] {
        guard let monthRange = calendar.range(of: .day, in: .month, for: displayedMonth),
              let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth)) else {
            return []
        }

        let weekdayOffset = calendar.component(.weekday, from: firstOfMonth) - 1
        var days: [Date?] = []

        for _ in 0..<weekdayOffset {
            days.append(nil)
        }

        days += monthRange.compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth)
        }
        
        return days
    }

    // 선택된 날짜에 따라 원형 또는 범위 배경 설정
    private func circleBackground(date: Date) -> Color {
        if date == startDate || date == endDate {
            return Color.accentColor
        }
        return Color.clear
    }
    
    // 텍스트 색상 설정
    private func textColor(for date: Date) -> Color {
        if date == startDate || date == endDate {
            return Color.white
        } else if calendar.component(.weekday, from: date) == 1 {
            return Color.red
        }
        return Color.primary
    }

    // 날짜 선택 처리
    private func handleDateSelection(date: Date) {
        if startDate == nil || (startDate != nil && endDate != nil) {
            // 출발 날짜를 선택하거나, 두 날짜가 선택된 상태에서는 출발 날짜를 다시 선택
            startDate = date
            endDate = nil
        } else if let startDate = startDate, date > startDate {
            // 출발 날짜가 선택된 상태에서 귀국 날짜를 선택
            endDate = date
        } else {
            // 출발 날짜가 선택된 상태에서 그 이전 날짜를 선택할 경우 출발 날짜를 갱신
            startDate = date
            endDate = nil
        }
    }
}

#Preview {
    CalendarView(startDate: .constant(Date()), endDate: .constant(Date()))
}

