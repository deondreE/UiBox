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
    @State private var isDropdownVisible: Bool = false
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            Button(action: {
                isDropdownVisible.toggle()
            }) {
                Text(selectedOption?.name ?? "Select an option")
                    .foregroundStyle(.black)
            }.overlay(
                Group {
                    if isDropdownVisible {
                        VStack {
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
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .topLeading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    }
                }
                
            )
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
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
    // Simulated JSON data
        let jsonString = """
        [
            {"id": 1, "name": "Option 1"},
            {"id": 2, "name": "Option 2"},
            {"id": 3, "name": "Option 3"}
        ]
        """
}
