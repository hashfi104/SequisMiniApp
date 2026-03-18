//
//  ImageDetailCommentView.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/18/26.
//

import SwiftUI

struct ImageDetailCommentView: View {
    var name: String
    var comment: String
    var timestamp: Date

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(name.getInitial())
                .font(.footnote)
                .foregroundStyle(.white)
                .padding(10)
                .background(Color.gray).clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.caption.bold())
                    .foregroundStyle(.black)
                Text(comment)
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.7))
                    .padding(.bottom, 4)
                Text(timestamp.getFullDateString())
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    ImageDetailCommentView(
        name: "Khairuna Yamini",
        comment: "Pertamax",
        timestamp: Date()
    )
}
