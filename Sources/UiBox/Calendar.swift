//
//  Calendar.swift
//  UiBoxTarget
//
//  Created by Deondre English on 1/6/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
struct CalendarView: View {
    @State private var month: Date
    @State private var selectedDate: Date?
    
    public init() {
        _month = State(initialValue: Date())
    }
    
    var body: some View {
        VStack {
            headerView
            daysGridView
        }
        .padding()
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                self.month = Calendar.current.date(byAdding: .month, value: -1, to: self.month) ?? self.month
            }) {
                Image(systemName: "chevron.left")
            }
            
            Text("\(month, formatter: DateFormatter.monthYearFormatter)")
            
            Button(action: {
                self.month = Calendar.current.date(byAdding: .month, value: 1, to: self.month) ?? self.month
            }) {
                Image(systemName: "chevron.right")
            }
         }
        .font(.headline)
        .padding(.vertical)
    }
    
    private var daysGridView: some View {
        VStack {
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
struct DayView: View {
    let day: Date

    var body: some View {
        Text("\(day, formatter: DateFormatter.dayFormatter)")
            .frame(width: 30, height: 30)
            .background(day == Date() ? Color.blue : Color.clear)
            .cornerRadius(15)
            .padding(5)
    }
}

@available(iOS 17.0, macOS 14.0, *)
extension Date {
    func allDaysInMonth() -> [Date] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.map { calendar.date(bySetting: .day, value: $0, of: self)! }
    }
}

@available(iOS 17.0, macOS 14.0, *)
extension DateFormatter {
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

