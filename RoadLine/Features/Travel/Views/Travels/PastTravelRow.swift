//
//  PastTravelRow.swift
//  RoadLine
//
//  Created by 최서희 on 11/7/24.
//

import SwiftUI
import ComposableArchitecture
import RealmSwift

struct PastTravelRow: View {
    let travel: Travel
    let store: StoreOf<TravelFeature>
    @State private var offsetX: CGFloat = 0
    @GestureState private var isDragging = false
    
    var body: some View {
        WithViewStore(store, observe: \.pastTravels) { viewStore in
            ZStack {
                // 삭제 버튼 영역
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            offsetX = 0
                        }
                        viewStore.send(.deleteTravel(id: travel.id))
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                }
                
                // 여행 정보 영역
                HStack {
                    NavigationLink(destination: Itinerary()) {
                        HStack(alignment: .center, spacing: 14) {
                            Circle()
                                .frame(width: 60, height: 60)
                                .shadow(radius: 10)
                                .foregroundColor(.primary)
                            VStack(alignment: .leading, spacing: 3) {
                                Text(travel.country)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("\(travel.departureDate.dateToString(format: .yyyyMMddDot)) - \(travel.returnDate.dateToString(format: .yyyyMMddDot))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(travel.notes)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .frame(height: 80)
                    }
                }
                .padding(.horizontal, 12)
                .background(Color.darkPrimary)
                .offset(x: offsetX)
                .highPriorityGesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 {
                                offsetX = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -100 {
                                withAnimation {
                                    offsetX = -60
                                }
                            } else {
                                withAnimation {
                                    offsetX = 0
                                }
                            }
                        }
                )
                .onAppear {
                    withAnimation {
                        offsetX = 0
                    }
                }
            }
        }
    }
}
