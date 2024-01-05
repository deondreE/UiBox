//
//  Avatar.swift
//
//
//  Created by deondreE on 1/4/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
struct Avatar: View {
    
    private var imageSrc: String
    
    public init(imageSrc: String) {
        self.imageSrc = imageSrc
    }
    
    var body: some View {
        Image(imageSrc)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
