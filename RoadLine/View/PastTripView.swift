//
//  PastTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI

struct PastTripView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    
    var body: some View {
        VStack {
            Text("지난 여행")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(travelViewModel.pastTravels, id: \.self) { travelID in
                NavigationLink {
                    TravelPlanView(travelID: travelID)
                } label: {
                    PastTripRowView(travelID: travelID)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }
}

#Preview {
    PastTripView()
        .environmentObject(TravelViewModel())
}
