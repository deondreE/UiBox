//
//  Avatar.swift
//
//
//  Created by deondreE on 1/4/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
/// The small image type used for user images often.
public struct Avatar: View {
    
    private var imageSrc: String = ""
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    public init(imageSrc: String, width: CGFloat, height: CGFloat) {
        self.imageSrc = imageSrc
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        Image(imageSrc)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .frame(width: width, height: height)
            .shadow(radius: 5)
    }
}
