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

    
    public init() {
        _month = State(initialValue: Date())
    }
    
    public var body: some View {
        VStack {
            headerView
                .padding(.top, 20)
          daysHeaderView
            .padding()
            daysGridView
                .padding(.vertical)
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
                self.month = Calendar.current.date(byAdding: .month, value: -1, to: self.month) ?? self.month
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
  
    private var daysHeaderText: some View {
      Text("T")
        .foregroundStyle(.white)
    }
  
    private var daysHeaderView: some View {
      LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
        daysHeaderText
      }
    }
    
    private var daysGridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
            ForEach(month.allDaysInMonth(), id: \.self) { day in
                DayView(day: day, isHighlighted: highlightedDays.contains(String(Calendar.current.component(.day, from: day))))
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
public struct DayView: View {
    let day: Date
    let isHighlighted: Bool
    
    public var body: some View {
        Text("\(day, formatter: DateFormatter.dayFormatter)")
            .frame(width: 30, height: 30)
            .background(isHighlighted ? Color.gray : (day == Date() ? Color.blue : Color.clear))
            .foregroundStyle(isHighlighted ? Color.white : (day.isInWeekend() ? Color.gray : Color.white))
            .cornerRadius(15)
            .padding(5)
    }
}

@available(iOS 17.0, macOS 14.0, *)
public extension Date {
    func allDaysInMonth() -> [Date] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.map { calendar.date(bySetting: .day, value: $0, of: self)! }
    }
    
    // This is not returning the correct values.
    func isInWeekend() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInWeekend(self) // FIX HERE.
    }
}

@available(iOS 17.0, macOS 14.0, *)
public extension DateFormatter {
    static let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
}

