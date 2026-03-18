//
//  Date+Extension.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/18/26.
//

import Foundation

extension Date {
    func getFullDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
