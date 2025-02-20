//
//  ScheduleList.swift
//  RoadLine
//
//  Created by 최서희 on 2/18/25.
//

import SwiftUI
import ComposableArchitecture
import RealmSwift

struct ScheduleList: View {
    let store: StoreOf<ScheduleFeature>
    let schedules: [Schedule]
    
    var body: some View {
        VStack(spacing: 0) {
            WithViewStore(store, observe: \.schedules) { viewStore in
                LazyVStack {
                    ForEach(viewStore.state, id: \.id) { schedule in
                        Text(schedule.title)
                    }
                }
            }
            
        } //:VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            print(schedules.count)
        }
    }
}

#Preview {
    // Schedule()
}
