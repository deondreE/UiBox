//
//  ComboBox.swift
//  UiBoxTarget
//
//  Created by Deondre English on 1/6/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
public struct ComboBox: View {
    @State private var selectedOption: String = "Option 1"
    private let options = ["Option 1", "Option 2", "Option 2"]
    public var body: some View {
        VStack {
            Text("Selected Option: \(selectedOption)")
            
            Picker("Options", selection: $selectedOption) {
                ForEach(options, id: \.self) {option in
                    Text(option).tag(option)
                }
            }
            .padding()
        }
    }
}
