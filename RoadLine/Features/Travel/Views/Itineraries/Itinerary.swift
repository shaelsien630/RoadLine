//
//  Itinerary.swift
//  RoadLine
//
//  Created by 최서희 on 11/11/24.
//

import SwiftUI
import RealmSwift

struct Itinerary: View {
    // @EnvironmentObject var travelViewModel: TravelViewModel
    @State private var selectedDate = 8 // Today와 가장 인접한 날짜
    @State private var showMap = false
    // let travelID: ObjectId
    
    let dates = [8, 9, 10, 11, 12, 13]
    var body: some View {
        // Text("\(travelID)")
        
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    VStack(spacing: 5) {
                        Text("ALL")
                            .font(.caption)
                            .frame(width: 22, height: 22, alignment: .center)
                            .padding(10)
                            .background(selectedDate == 0 ? Color.accentColor : Color.gray.opacity(0.1))
                            .foregroundColor(selectedDate == 0 ? .white : .black)
                            .cornerRadius(100)
                            .onTapGesture {
                                selectedDate = 0
                            }
                        Spacer()
                    }
                    
                    ForEach(dates, id: \.self) { date in
                        VStack(spacing: 5) {
                            Text("\(date)")
                                .font(.subheadline)
                                .frame(width: 16, height: 16, alignment: .center)
                                .padding(10)
                                .background(selectedDate == date ? Color.accentColor : Color.gray.opacity(0.1))
                                .foregroundColor(selectedDate == date ? .white : .black)
                                .cornerRadius(100)
                                .onTapGesture {
                                    selectedDate = date
                                }
                            Text("월")
                                .font(.caption)
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 30)
            
        } //:VSTACK
    }
}

#Preview {
    // Itinerary(travelID: "0")
}
