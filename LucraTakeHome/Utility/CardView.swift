//
//  CardView.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import SwiftUI

/// A generic view that will remotely load an image and display it in a card style.
struct CardView: View {
    var imageUrl: String
    var scale: Double
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 3)
                    .padding(.horizontal, 8)
                
                AsyncImage(url: URL(string: imageUrl), scale: scale) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: reader.size.width, height: 220)
                        .clipped()
                        .cornerRadius(25)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.horizontal, 8)
                }
                .frame(width: reader.size.width)
        }
    }
}
