//
//  PastTripView.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import RealmSwift

struct PastTripView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    
    @State private var offset: CGFloat = 0
    @GestureState private var isDragging = false
    
    var body: some View {
        VStack {
            Text("지난 여행")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            LazyVStack {
                ForEach(travelViewModel.pastTravels, id: \.id) { travel in
                    PastTripRowView(travelID: travel.id, onDelete: {
                        withAnimation(.easeInOut) {
                            travelViewModel.deleteTravel(by: travel.id)
                            travelViewModel.fetchItems()
                        }
                    })
                    .transition(.move(edge: .leading))
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    PastTripView()
        .environmentObject(TravelViewModel())
}
