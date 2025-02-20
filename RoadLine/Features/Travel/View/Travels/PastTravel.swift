//
//  PastTravel.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import ComposableArchitecture

struct PastTravel: View {
    let store: StoreOf<TravelFeature>
    
    var body: some View {
        WithViewStore(store, observe: \.pastTravels) { viewStore in
            VStack {
                Text("지난 여행")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                
                LazyVStack {
                    ForEach(viewStore.state, id: \.id) { travel in
                        PastTravelRow(travel: travel, store: store)
                            .transition(.move(edge: .leading))
                    }
                }
                .padding(.horizontal, 12)
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    PastTravel(
        store: Store(
            initialState: TravelFeature.State(),
            reducer: { TravelFeature() }
        )
    )
}
