//
//  Date.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import Foundation


extension Date {
    func formattedDate() -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          formatter.timeStyle = .none
          
          let calendar = Calendar.current
          if calendar.isDateInToday(self) {
              return NSLocalizedString("Today", comment: "Today")
          } else if calendar.isDateInYesterday(self) {
              return NSLocalizedString("Yesterday", comment: "Yesterday")
          } else {
              return formatter.string(from: self)
          }
      }
}
