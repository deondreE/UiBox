//
//  Calendar.swift
//  UiBoxTarget
//
//  Created by Deondre English on 1/6/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
public struct Event {
  public var name: String
  public var day: Date?
}

@available(iOS 17.0, macOS 14.0, *)
public struct EventPopup: View {
  @Binding var eventName: String
  @Binding private var isShowingPopup: Bool
  @Binding private var selectedDate: Date?
  @Binding private var events: [Event]

  public init(eventName: Binding<String>, isShowingPopup: Binding<Bool>, selectedDate: Binding<Date?>, events: Binding<[Event]>) {
    self._eventName = eventName
    self._isShowingPopup = isShowingPopup
    self._selectedDate = selectedDate
    self._events = events
  }

  public var body: some View {
    VStack(alignment: .trailing) {

      HStack {
        Spacer()
        TextField("Event Name", text: $eventName)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.black)
              .stroke(Color.gray, lineWidth: 1)
              .frame(width: 150, height: 40)
              .padding(2)
          ).frame(width: 150, height: 200).foregroundStyle(.white).padding(2)

        Button(action: {
          print("Event Name: \(eventName)")
          addEventOnSelectedDay()
          self.isShowingPopup.toggle()
        }) {
          Image(systemName: "plus.circle")
            .font(.title)
            .foregroundStyle(.green)
        }

        Button(action: {
          self.isShowingPopup.toggle()
        }) {
          Image(systemName: "xmark.circle")
            .foregroundStyle(.red)
            .font(.title)
        }

      }

      .frame(width: 300, height: 150)
    }
  }
  
  @available(iOS 17.0, macOS 14.0, *)
  private func addEventOnSelectedDay() {
    guard let selectedDate = selectedDate else {
      return
    }
    
    let newEvent = Event(name: eventName, day: selectedDate)
    events.append(newEvent)

    print("Event added on date: \(eventName)")
  }
}

@available(iOS 17.0, macOS 14.0, *)
public struct CalendarView: View {
  @State private var month: Date
  @State private var selectedDate: Date?
  @State private var highlightedDays: Set<String> = []
  @State private var events: [Event] = []
  @State private var eventName: String = ""
  @State private var isAddingEvent: Bool = false
  private let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]

  public init() {
    _month = State(initialValue: Date())
  }

  public var body: some View {
    VStack {
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
      
      if isAddingEvent {
        EventPopup(eventName:$eventName, isShowingPopup: $isAddingEvent, selectedDate: $selectedDate, events: $events)
      }
    }
    
    
      
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
          .foregroundStyle(.blue)
      }.padding(.horizontal, 2)

      Text("\(month, formatter: DateFormatter.monthYearFormatter)")
        .font(.title)
        .bold()

      Button(action: {
        self.month = Calendar.current.date(byAdding: .month, value: 1, to: self.month) ?? self.month
      }) {
        Image(systemName: "chevron.right.circle.fill")
          .font(.title)
          .foregroundStyle(.blue)
      }.padding(.horizontal, 2)

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
    VStack {
      LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
        ForEach(month.allDaysInMonth(), id: \.self) { day in
          let hasEventForDay = hasEvent(for: day)
          DayView(
            day: day,
            isHighlighted: highlightedDays.contains(
              String(Calendar.current.component(.day, from: day))),
            hasEvent: hasEventForDay  // Check if the day has an event
          )
          .onTapGesture {
            self.selectedDate = day
            self.toggleHighlight(day)
          }
        }
      }
      .overlay {
        HStack {
          Spacer()  // Add a Spacer to push the button to the right

          Button(action: {
            isAddingEvent.toggle()
          }) {
            Image(systemName: "plus.circle")
              .font(.title2)
              .foregroundStyle(.blue)
          }
        }
        .padding(.top, 200)  // maybe make this better
        .padding(.horizontal, 6)
      }
    }
  }

  @available(iOS 17.0, macOS 14.0, *)
  private func hasEvent(for day: Date) -> Bool {
      // Check if there is an event for the specified day
      return events.contains { event in
          if let eventDay = event.day {
              return Calendar.current.isDate(eventDay, inSameDayAs: day)
          }
          return false
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
  let hasEvent: Bool

  public var body: some View {
    VStack {
      Text("\(day, formatter: DateFormatter.dayFormatter)")
        .cornerRadius(15)
        .frame(width: 30, height: 30)
        .foregroundStyle(isHighlighted ? Color.white : (day.isInWeekend() ? Color.gray : Color.white))
        .background(
          isHighlighted
            ? Color(UIColor(hex: "#a3a3a3", alpha: 0.8)) : (day == Date() ? Color.blue : Color.clear))
      if hasEvent {
        Circle()
          .fill(Color.orange)
          .frame(width: 5, height: 5)
      }
    }.frame(width: 40, height: 40).frame(maxHeight: 40)
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

#Preview {
  CalendarView()
    .padding()
}
