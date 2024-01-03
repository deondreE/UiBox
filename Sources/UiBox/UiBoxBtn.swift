//
//  SwiftUIView.swift
//  
//
//  Created by Deondre English on 1/3/24.
//

import SwiftUI

@available(macOS 10.15, *)
struct UiBoxBtn: View {
    
    @Binding var innerText: String
    @Binding var textBold: Bool
    
    public init(innerText: Binding<String>, textBold: Binding<Bool>) {
        self._innerText = innerText
        self._textBold = textBold
    }
    
    var body: some View {
        Button  {
                // callback
        } label: {
            // TODO: do this with turnary operation.
            if textBold {
                Text(innerText)
                    .bold()
            } else {
                Text(innerText)

            }
        }
    }
}
