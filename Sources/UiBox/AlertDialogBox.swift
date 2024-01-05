//
//  AlertDialogBox.swift
//
//
//  Created by Deondre English on 1/4/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
struct AlertDialogBox: View {
    private var headingText: String
    private var innerText: String
    
    private var btn1Text: String
    private var btn2Text: String
    
    public init(headingText: String, innerText: String, btn1Text: String, btn2Text: String) {
        self.headingText = headingText
        self.innerText = innerText
        self.btn1Text = btn1Text
        self.btn2Text = btn2Text
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Are you absolutely sure?")
                .bold()
                .font(.title2)
                .foregroundStyle(.white)
                .padding(10)
            
            ScrollView {
                Text("This action cannot be undone. This will permenatly delete your account and remove your data from our servers.")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            .frame(width: 350, height: 60)
            .padding(0)
            
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("Quit")
                        .bold()
                        .foregroundStyle(.white)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 85, height: 35)
                )
                .padding(20)
                
                Button {
                    
                } label: {
                    Text("Continue")
                        .bold()
                        .foregroundStyle(.black)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 85, height: 35)
                )
                .padding(10)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .stroke(Color.gray, lineWidth: 1)
        )
        .frame(width: 350, height: 250)
    }
}
