//
//  ProgressBar.swift
//  
//
//  Created by Deondre English on 1/4/24.
//

import SwiftUI

// actual progress bar.
@propertyWrapper
@available(iOS 17.0, macOS 14.0, *)
public struct BoundValue<T: BinaryFloatingPoint> {
    private var value: T
    
    public var wrappedValue: T {
        get { value }
        set { value = min(max(newValue, 0), 1)} // clamp the value to 0->1
    }
    
    public init(wrappedValue: T) {
        self.value = wrappedValue
    }
}

/// Progress view that allows for Styles.
/// Also allows for changing increment, values.
@available(iOS 17.0, macOS 14.0, *)
public struct ProgressBarStyle: ProgressViewStyle {
  var completedColor: Color
  var remainingColor: Color
  var increments: Int

  public func makeBody(configuration: Configuration) -> some View {
      VStack{
          ZStack(alignment: .leading) {
              GeometryReader { geometry in
                  ForEach(0..<increments, id: \.self) {increment in
                          RoundedRectangle(cornerRadius: 8)
                          .frame(width: (geometry.size.width / CGFloat(increments)) * CGFloat(increment), height: 15)
                          .foregroundColor(increment < Int(configuration.fractionCompleted! * CGFloat(increments)) ? completedColor : remainingColor)
                  }
              }
          }
      }
      .cornerRadius(8.0)
  }
}


@available(iOS 17.0, macOS 14.0, *)
public struct ProgressBar: View {
    @BoundValue var progress: Double = 0.0
    
    public init(progress: BoundValue<Double>) {
        self._progress = progress
    }
    
  public var body: some View {
    VStack {
        ProgressView("Loading...", value: self.progress)
            .progressViewStyle(ProgressBarStyle(completedColor: .blue, remainingColor: .red, increments: 10))
            .padding(10)
    }
  }
}
