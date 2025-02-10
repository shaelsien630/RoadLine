//
//  CommingTravel.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import ComposableArchitecture

struct CommingTravel: View {
    let store: StoreOf<TravelFeature>
    
    var body: some View {
        WithViewStore(store, observe: \.comingTravels) { viewStore in
            VStack(spacing: 20) {
                Text("다가오는 여행")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack {
                    ForEach(viewStore.state, id: \.id) { travel in
                        // 각 여행 행(row)에는 travel 데이터와 store를 전달합니다.
                        CommingTravelRow(travel: travel, store: store)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    CommingTravel(
        store: Store(
            initialState: TravelFeature.State(),
            reducer: { TravelFeature() }
        )
    )
}
