//
//  ImageDetailView.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/17/26.
//

import SwiftData
import SwiftUI

struct ImageDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var item: ImageDetailItem
    private var viewModel: ImageDetailViewModel

    init(item: ImageDetailItem, viewModel: ImageDetailViewModel = ImageDetailViewModel()) {
        self.item = item
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 8) {
            cardImageView
                .frame(height: 150)
                .padding(.vertical, 0)
            List {
                ForEach(item.comments.sorted { $0.timestamp > $1.timestamp }, id: \.self) { data in
                    ImageDetailCommentView(
                        name: data.name, comment: data.detail, timestamp: data.timestamp
                    )
                        .listRowBackground(Color.white)
                }
                .onDelete { offsets in
                    withAnimation {
                        $item.wrappedValue.comments.remove(atOffsets: offsets)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaPadding(.top)
        .background(Color.white)
        .toolbarBackground(Color(red: 0.95, green: 0.95, blue: 0.95), for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Image Detail")
                    .foregroundColor(.black)
                    .font(.headline.bold())
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Image List")
                    }
                    .foregroundColor(.blue)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        let comment = ImageDetailItemComment(
                            name: viewModel.generatedRandomNames,
                            detail: viewModel.generatedRandomComments,
                            timestamp: Date()
                        )
                        $item.wrappedValue.comments.append(comment)
                    }
                }) {
                    Label("Add", systemImage: "plus")
                }
                .labelStyle(.iconOnly)
            }
        }
    }

    @ViewBuilder
    var cardImageView: some View {
        if let image = cachedImages[item.imageUrl] {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            AsyncImage(url: URL(string: item.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
