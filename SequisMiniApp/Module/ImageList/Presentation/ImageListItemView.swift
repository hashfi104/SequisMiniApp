//
//  ImageListItemView.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/16/26.
//

import SwiftUI

struct ImageListItemView: View {
    var imageUrl: String
    var title: String

    init(imageUrl: String, title: String) {
        self.imageUrl = imageUrl
        self.title = title
    }

    var body: some View {
        HStack(spacing: 0) {
            cardImageView
            .frame(width: 150)
            .padding(.vertical, 0)
            .clipShape(
                UnevenRoundedRectangle(topLeadingRadius: 8, bottomLeadingRadius: 8)
            )
            VStack(alignment: .center) {
                Text("Author:")
                    .font(.caption.bold())
                    .foregroundStyle(Color.black)
                Text(title)
                    .font(.caption.bold())
                    .foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .gray, radius: 4)
    }

    @ViewBuilder
    var cardImageView: some View {
        if let image = cachedImages[imageUrl] {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
