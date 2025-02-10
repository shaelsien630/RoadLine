//
//  RoadLineApp.swift
//  RoadLine
//
//  Created by 최서희 on 11/5/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct RoadLineApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: Store(
                    initialState: TravelFeature.State(),
                    reducer: { TravelFeature() }
                )
            )
        }
    }
}
