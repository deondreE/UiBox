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
    
    public init() {
        _month = State(initialValue: Date())
    }
    
    public var body: some View {
        VStack {
            headerView
                .padding(.top, 20)
            daysGridView
                .padding(.vertical)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                self.month = Calendar.current.date(byAdding: .month, value: -1, to: self.month) ?? self.month
            }) {
                Image(systemName: "chevron.left")
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
         }
        .foregroundStyle(Color.black)
    }
    
    private var daysGridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
            ForEach(month.allDaysInMonth(), id: \.self) { day in
                DayView(day: day)
                    .onTapGesture {
                        self.selectedDate = day
                    }
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, *)
public struct DayView: View {
    let day: Date

    public var body: some View {
        Text("\(day, formatter: DateFormatter.dayFormatter)")
            .frame(width: 30, height: 30)
            .background(day == Date() ? Color.blue : Color.clear)
            .foregroundStyle(day.isInWeekend() ? .red : .primary)
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
    
    func isInWeekend() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInWeekend(self)
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

