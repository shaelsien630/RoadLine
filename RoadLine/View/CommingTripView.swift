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
    @ObservedResults(
        Travel.self,
        filter: NSPredicate(format: "isComming == true"),
        sortDescriptor: SortDescriptor(keyPath: "returnDate", ascending: false)
    ) var commingTravels
    
    var body: some View {
        VStack(spacing: 15) {
            Text("다가오는 여행")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack {
                ForEach(commingTravels, id: \.id) { travel in
                    CommingTirpRowView(travelID: travel.id, onDelete: {
                        withAnimation(.easeInOut) {
                            travelViewModel.removeTravel(by: travel.id)
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
