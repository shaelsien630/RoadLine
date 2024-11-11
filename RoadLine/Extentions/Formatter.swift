//
//  Formatter.swift
//  RoadLine
//
//  Created by 최서희 on 11/11/24.
//

import Foundation

extension Date {
    func dateToString(format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

enum DateFormat: String {
    case yyyyMMdd = "yyyy년 MM월 dd일"
    case yyyyMMddDot = "yyyy.MM.dd"
    case yyyyMMddHypen = "yyyy-MM-dd"
}
