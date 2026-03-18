//
//  ImageListView.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/10/26.
//

import Combine
import SwiftData
import SwiftUI

struct ImageListView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject private var state: ImageListViewModel.State
    private let action = ImageListViewModel.Action()

    @State private var vm: ImageListViewModel
    var cancellables = Set<AnyCancellable>()

    init(modelContext: ModelContext) {
        let viewModel = ImageListViewModel(modelContext: modelContext)
        _vm = State(initialValue: viewModel)
        self.state = viewModel.transform(action, &cancellables)
    }

    var body: some View {
        NavigationStack {
            List (state.imageListItems, id: \.id) { item in
                ImageListItemView(imageUrl: item.downloadUrl, title: item.author)
                    .listRowBackground(Color.white)
                    .listRowSpacing(8)
                    .onAppear {
                        if cachedImages[item.downloadUrl] == nil {
                            action.downlodImages.send(item.downloadUrl)
                        }
                        if item == state.imageListItems.last && !state.isLoadMore {
                            action.loadMoreImages.send()
                        }
                    }
                    .onTapGesture {
                        action.getImageDetail.send(item)
                    }
            }
            .navigationDestination(item: $state.selectedImage) { item in
                ImageDetailView(item: item)
            }
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 0.95, green: 0.95, blue: 0.95), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Image List")
                        .foregroundColor(.black)
                        .font(.headline.bold())
                }
            }
            .onAppear {
                if state.isFirstLoad {
                    action.fetchImages.send()
                }
            }
        }
    }
}
