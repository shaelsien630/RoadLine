//
//  CommingTravelRow.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import ComposableArchitecture
import RealmSwift

struct ComingTravelRow: View {
    let travel: Travel
    let store: StoreOf<TravelFeature>
    @State private var showAlert = false
    var body: some View {
        WithViewStore(store, observe: \.comingTravels) { viewStore in
            NavigationLink(destination: Itinerary(travel: travel)) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.primary)
                    .shadow(radius: 10)
                    .frame(height: 160)
                    .overlay(
                        VStack(spacing: 6) {
                            Text(travel.country)
                                .font(.title2)
                                .bold()
                            
                            Text("\(travel.departureDate.dateToString(format: .yyyyMMddDot)) - \(travel.returnDate.dateToString(format: .yyyyMMddDot))")
                                .font(.subheadline)
                        }
                        .foregroundColor(.darkPrimary)
                    )
                    .onLongPressGesture {
                        showAlert = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("여행 삭제"),
                            message: Text("정말 여행을 삭제하시겠습니까?"),
                            primaryButton: .destructive(Text("Delete"), action: {
                                viewStore.send(.deleteTravel(id: travel.id))
                            }),
                            secondaryButton: .cancel()
                        )
                    }
            }
        }
    }
}
