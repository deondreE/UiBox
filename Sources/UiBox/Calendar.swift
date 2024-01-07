//
//  Calendar.swift
//  UiBoxTarget
//
//  Created by Deondre English on 1/6/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
public struct CalendarView: View {
  @State private var month: Date
  @State private var selectedDate: Date?
  @State private var highlightedDays: Set<String> = []
  private let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]

  public init() {
    _month = State(initialValue: Date())
  }

  public var body: some View {
    VStack {
      headerView
        .padding(.top, 10)
      daysHeaderView
      daysGridView
        .padding(.top, 3)
    }
    .padding()
    .background(Color.black)
    .cornerRadius(20)
    .shadow(radius: 10)
  }

  // Header View for the calendar
  private var headerView: some View {
    HStack {
      Button(action: {
        self.month =
          Calendar.current.date(byAdding: .month, value: -1, to: self.month) ?? self.month
      }) {
        Image(systemName: "chevron.left.circle.fill")
          .font(.title)
      }

      Text("\(month, formatter: DateFormatter.monthYearFormatter)")
        .font(.headline)

      Button(action: {
        self.month = Calendar.current.date(byAdding: .month, value: 1, to: self.month) ?? self.month
      }) {
        Image(systemName: "chevron.right.circle.fill")
          .font(.title)
      }
      // add create event button here.
    }
    .foregroundStyle(Color.white)
  }

  private var daysHeaderView: some View {
    VStack {
      HStack {
        ForEach(daysOfWeek, id: \.self) { day in
          Text(day)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 2)
            .padding(.top, 2)
            .foregroundStyle(.white)
            .font(.headline)
            .bold()
        }
      }
      Divider()
        .background(Color.gray)
    }
  }

  private var daysGridView: some View {
    LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
      ForEach(month.allDaysInMonth(), id: \.self) { day in
        DayView(
          day: day,
          isHighlighted: highlightedDays.contains(
            String(Calendar.current.component(.day, from: day)))
        )
        .onTapGesture {
          self.selectedDate = day
          self.toggleHighlight(day)
        }
      }
    }
  }

  private func toggleHighlight(_ day: Date) {
    let dayNumber = String(Calendar.current.component(.day, from: day))
    if highlightedDays.contains(dayNumber) {
      highlightedDays.remove(dayNumber)
    } else {
      highlightedDays.insert(dayNumber)
    }
  }
}

@available(iOS 17.0, macOS 14.0, *)
public struct EventOverlay: View {
  public var body: some View {
    HStack {

    }
  }
}

@available(iOS 17.0, macOS 14.0, *)
public struct DayView: View {
  let day: Date
  let isHighlighted: Bool

  public var body: some View {
    Text("\(day, formatter: DateFormatter.dayFormatter)")
      .cornerRadius(15)
      .frame(width: 30, height: 30)
      .padding(5)
      .foregroundStyle(isHighlighted ? Color.white : (day.isInWeekend() ? Color.gray : Color.white))
      .background(isHighlighted ? Color(UIColor(hex: "#a3a3a3", alpha: 0.8)) : (day == Date() ? Color.blue : Color.clear))
  }
}

@available(iOS 17.0, macOS 14.0, *)
extension Date {
  public func allDaysInMonth() -> [Date] {
    let calendar = Calendar.current
    let range = calendar.range(of: .day, in: .month, for: self)!
    return range.map { calendar.date(bySetting: .day, value: $0, of: self)! }
  }

  // This is not returning the correct values.
  public func isInWeekend() -> Bool {
    let calendar = Calendar.current
    return calendar.isDateInWeekend(self)  // FIX HERE.
  }
}

@available(iOS 17.0, macOS 14.0, *)
extension DateFormatter {
  public static let monthYearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
  }()

  public static let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    return formatter
  }()
}

// TODO: put this in a util struct.
@available(iOS 17.0, macOS 14.0, *)
extension UIColor {
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat((rgb & 0x0000FF)) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
