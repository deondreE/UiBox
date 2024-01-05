//
//  SwiftUIView.swift
//  
//
//  Created by Deondre English on 1/3/24.
//

import SwiftUI
import Foundation

@available(iOS 17.0, macOS 14.0, *)
public struct UiBoxBtn: View {
    
    @Binding var innerText: String
    @Binding var textBold: Bool
    
    public init(innerText: Binding<String>, textBold: Binding<Bool>) {
        self._innerText = innerText
        self._textBold = textBold
    }
    
    public var body: some View {
        Button  {
                // callback
        } label: {
            if self.textBold {
                Text(self.innerText)
                    .bold()
                    .foregroundStyle(Color.white)
            } else {
                Text(self.innerText)
                    .foregroundStyle(Color.white)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .stroke(Color.gray, lineWidth: 1)
        )
        .frame(width: 150, height: 80)
    }
}
