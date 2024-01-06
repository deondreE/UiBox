//
//  ComboBox.swift
//  UiBoxTarget
//
//  Created by Deondre English on 1/6/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
struct Option: Identifiable, Codable, Hashable {
  var id: Int
  var name: String
}

@available(iOS 17.0, macOS 14.0, *)
public struct ComboBox: View {
  @State private var selectedOption: Option?
  @State private var options: [Option] = []
  @State private var filteredOptions: [Option] = []
  @State private var searchText: String = ""
  @State private var isDropdownVisible: Bool = false
  @State private var contentHeight: CGFloat = 0
  @State private var buttonPosition: CGPoint = .zero

  public init() {

  }

  public var body: some View {
    VStack {
      Button(action: {
        isDropdownVisible.toggle()
      }) {
        Text(selectedOption?.name ?? "Select an option")
          .foregroundStyle(.black)
      }
      .background(
        GeometryReader {
          Color.clear
            .preference(key: ButtonPositionPreferenceKey.self, value: $0.frame(in: .global).origin)
        }
      )
      
      Group {
        if isDropdownVisible {
          GeometryReader { geometry in
            VStack {
              TextField("Search", text: $searchText)
                .padding(.top)
                .padding(.horizontal, 2)
                .padding(.vertical, 2)
                .background(
                  Rectangle()
                    .fill(Color.black)
                    .stroke(Color.gray, lineWidth: 1)
                )
                .foregroundStyle(.white)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .onChange(of: searchText) {
                  if searchText != "" {
                    filterOptions()
                  }
                }

              ForEach(options, id: \.self) { option in
                Button(action: {
                  selectedOption = option
                  isDropdownVisible.toggle()
                }) {
                  Text(option.name)
                }
                .background(.black)
                .foregroundStyle(.white)
                .padding(10)
              }
            }
            .onPreferenceChange(HeightPreferenceKey.self) {
              contentHeight = $0
            }
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            // .frame(maxWidth: 250, maxHeight: 165, alignment: .topLeading)
            .frame(height: contentHeight > geometry.size.height ? geometry.size.height : contentHeight)
            .padding(.horizontal)
            .position(x: buttonPosition.x + geometry.size.width / 2, y: buttonPosition.y + geometry.size.height + contentHeight / 2 + 10)
          }
        }
      }
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.black)
          .stroke(Color.gray, lineWidth: 1)
      )
      .onAppear {
        if let jsonData = jsonString.data(using: .utf8) {
          do {
            let decodedOptions = try JSONDecoder().decode([Option].self, from: jsonData)
            options = decodedOptions
          } catch {
            print("Error decoding json: \(error)")
          }
        }
      }
    }
  }

  // filter the search options, so that they are inorder.
  private func filterOptions() {
    if searchText.isEmpty {
      filteredOptions = options
    } else {
      filteredOptions = options.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
  }
  
  // Height of the current objects, with the addition to the core object.
  private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value  =  max(value, nextValue())
    }
  }
  
  // Return the CGPoint of where the button is located.
  private struct ButtonPositionPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
      value = nextValue()
    }
  }
  
  // Simulated JSON data
  let jsonString = """
    [
        {"id": 1, "name": "Option 1"},
        {"id": 2, "name": "Option 2"},
        {"id": 3, "name": "Option 3"}
    ]
    """
}
