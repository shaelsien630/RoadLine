//
//  TravelPlanView.swift
//  RoadLine
//
//  Created by 최서희 on 11/11/24.
//

import SwiftUI
import RealmSwift

struct TravelPlanView: View {
    let travelID: ObjectId
    
    var body: some View {
        Text("\(travelID)")
    }
}

// #Preview {
//     TravelPlanView(travelID: "0")
// }
