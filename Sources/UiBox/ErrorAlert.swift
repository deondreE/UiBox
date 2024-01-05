//
//  ErrorAlert.swift
//  
//
//  Created by Deondre English on 1/4/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
public struct ErrorAlert: View {
    @Binding var errorText: String
    
    public init(errorText: Binding<String>) {
        self._errorText = errorText
    }
    
    public var body: some View {
        VStack {
            // TODO: Add icon for the error.
            ScrollView {
                Text("Error")
                    .bold()
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: 250, alignment: .leading)
                Text(self.errorText)
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: 250, alignment: .leading)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .stroke(Color.red, lineWidth: 1)
        )
        .multilineTextAlignment(.leading)
        .frame(width: 450, height: 95)
        .fixedSize(horizontal: true, vertical: false)
    }
}
