//
//  MainView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var travelViewModel = TravelViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TitleView()
                ScrollView(.vertical, showsIndicators: false) {
                    CommingTripView()
                    PastTripView()
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .environmentObject(travelViewModel)
        }
    }
}

#Preview {
    MainView()
}
