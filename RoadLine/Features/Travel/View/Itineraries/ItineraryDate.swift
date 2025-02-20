//
//  ItineraryDate.swift
//  RoadLine
//
//  Created by 최서희 on 2/18/25.
//

import SwiftUI

import SwiftUI

struct ItineraryDate: View {
    let dates: [Date]
    @Binding var selectedDate: Date?
    @State private var scrollToDate: Date? = nil
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollViewReader { proxy in
            HStack(spacing: 14) {
                // "ALL" 버튼
                VStack(spacing: 5) {
                    Text("ALL")
                        .font(.caption)
                        .frame(width: 22, height: 22, alignment: .center)
                        .padding(10)
                        .background(selectedDate == nil ? Color.accentColor : (colorScheme == .light ? Color.gray.opacity(0.1) : Color.primary))
                        .foregroundColor(selectedDate == nil ? .white : .black)
                        .cornerRadius(100)
                        .onTapGesture {
                            withAnimation {
                                selectedDate = nil
                                proxy.scrollTo(dates.first, anchor: .center) // "ALL" 선택 시 첫 날짜로 스크롤
                            }
                        }
                    Text(selectedDate == nil ? "전체" : "\(selectedDate!.dateToString(format: .M))월")
                        .font(.caption)
                }
                
                // 가로 스크롤 가능한 날짜 선택
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(dates, id: \.self) { date in
                            VStack(spacing: 5) {
                                Text("\(date.dateToString(format: .d))")
                                    .font(.subheadline)
                                    .frame(width: 22, height: 22, alignment: .center)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .allowsTightening(true)
                                    .scaledToFit()
                                    .padding(10)
                                    .background(selectedDate == date ? Color.accentColor : (colorScheme == .light ? Color.gray.opacity(0.1) : Color.primary))
                                    .foregroundColor(selectedDate == date ? .white : .black)
                                    .cornerRadius(100)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedDate = date
                                            proxy.scrollTo(date, anchor: .center) // 선택한 날짜로 스크롤
                                        }
                                    }
                                Text("\(date.dateToWeekString())")
                                    .font(.caption)
                            }
                            .id(date) // 스크롤을 위해 ID 설정
                        }
                    }
                }
            }
            .frame(height: 30)
            .padding()
            .padding(.top, 4)
            .onAppear {
                // 오늘 날짜가 포함되어 있으면 기본 선택, 없으면 출발일 선택
                if let todayInDates = dates.first(where: { Calendar.current.isDate($0, inSameDayAs: Date()) }) {
                    scrollToDate = todayInDates
                } else {
                    scrollToDate = dates.first
                }
                
                if let scrollToDate = scrollToDate {
                    withAnimation {
                        proxy.scrollTo(scrollToDate, anchor: .center) // 초기 로드 시 오늘 날짜로 스크롤
                    }
                }
            }
        }
    }
}

