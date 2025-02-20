//
//  MainView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<TravelFeature>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // TitleView에 store 전달
                TitleView(store: store)
                ScrollView(.vertical, showsIndicators: false) {
                    // 다가오는 여행 및 지난 여행 뷰에 store 전달
                    ComingTravel(store: store)
                    PastTravel(store: store)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                store.send(.fetchAllTravels) // 앱이 실행되면 fetchAllTravels 실행
            }
        }
    }
}

#Preview {
    MainView(
        store: Store(
            initialState: TravelFeature.State(),
            reducer: { TravelFeature() }
        )
    )
}
