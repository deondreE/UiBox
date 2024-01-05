//
//  Container.swift
//
//
//  Created by Deondre English on 1/4/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
/// use this if you want the Rounded style of the framework.
public struct Container<Content: View>: View {
    private var content: () -> Content
    private var width: CGFloat
    private var height: CGFloat
    private var bgColor: Color
    
    public init(width: CGFloat, height: CGFloat, bgColor: Color, @ViewBuilder content: @escaping () -> Content) {
        self.width = width
        self.height = height
        self.bgColor = bgColor
        self.content = content
    }
    
    public var body: some View {
        VStack {
            content()
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
                .fill(Color.black)
        )
        .frame(width: width, height: height)
    }
}

