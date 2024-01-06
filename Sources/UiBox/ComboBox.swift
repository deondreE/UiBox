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
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            Text("Selected Option: \(selectedOption?.name ?? "")")
                .padding()
            
            Picker("Options", selection: $selectedOption) {
                ForEach(options) {option in
                    Text(option.name).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
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
    // Simulated JSON data
        let jsonString = """
        [
            {"id": 1, "name": "Option 1"},
            {"id": 2, "name": "Option 2"},
            {"id": 3, "name": "Option 3"}
        ]
        """
}
