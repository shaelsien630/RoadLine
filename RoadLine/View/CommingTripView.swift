//
//  CommingTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct CommingTripView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Text("다가오는 여행")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(travelViewModel.commingTravels, id: \.self) { travelID in
                NavigationLink {
                    TravelPlanView(travelID: travelID)
                } label: {
                    CommingTirpRowView(travelID: travelID)
                }

            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 24)
    }
}

#Preview {
    CommingTripView()
        .environmentObject(TravelViewModel())
}
