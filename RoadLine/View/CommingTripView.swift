//
//  CommingTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import RealmSwift

struct CommingTripView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("다가오는 여행")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack {
                ForEach(travelViewModel.comingTravels, id: \.id) { travel in
                    CommingTirpRowView(travelID: travel.id, onDelete: {
                        withAnimation(.easeInOut) {
                            travelViewModel.deleteTravel(by: travel.id)
                        }
                    })
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
