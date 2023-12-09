//
//  CircularImage.swift
//  SwiftUIBasics
//
//  Created by Diplomado on 08/12/23.
//

import SwiftUI

struct CircularImage: View {
    var imageName: String
    var size: CGFloat = 92
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size)
            .opacity(0.8)
            .clipShape(.circle)
            .overlay {
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 10)
    }
}
//para pruebas?
#Preview {
    CircularImage(imageName: "avatarProfile")
}
