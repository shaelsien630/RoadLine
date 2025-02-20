//
//  ScheduleMap.swift
//  RoadLine
//
//  Created by 최서희 on 2/18/25.
//

import SwiftUI
import ComposableArchitecture
import RealmSwift

struct ScheduleMap: View {
    let store: StoreOf<ScheduleFeature>
    let schedules: [Schedule]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("맵뷰 입니다")
            
        } //:VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    // ScheduleMapView()
}
