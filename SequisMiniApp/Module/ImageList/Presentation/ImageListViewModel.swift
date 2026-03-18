//
//  ImageListViewModel.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/17/26.
//

import Combine
import SwiftData
import SwiftUI

@Observable
class ImageListViewModel {
    var modelContext: ModelContext
    let usecase: ImageListUsecaseProtocol
    let imageUsecase: ImageDownloadUsecaseProtocol

    public init(
        modelContext: ModelContext,
        usecase: ImageListUsecaseProtocol = ImageListUsecase(),
        imageUsecase: ImageDownloadUsecaseProtocol = ImageDownloadUsecase(repository: ImageDownloadRepository())
    ) {
        self.modelContext = modelContext
        self.usecase = usecase
        self.imageUsecase = imageUsecase
    }

    class State: ObservableObject {
        @Published var isFirstLoad = true
        @Published var imageListItems: [ImageListItemEntity] = []
        @Published var isLoadMore = false
        @Published var selectedImage: ImageDetailItem?
    }

    struct Action {
        let fetchImages = PassthroughSubject<Void, Never>()
        let downlodImages = PassthroughSubject<String, Never>()
        let loadMoreImages = PassthroughSubject<Void, Never>()
        let getImageDetail = PassthroughSubject<ImageListItemEntity, Never>()
    }

    func transform(_ action: Action, _ cancellables: inout Set<AnyCancellable>) -> State {
        let state = State()

        action.fetchImages
            .sink { _ in
                Task {
                    do {
                        let updatedImages = try await self.usecase.fetchImageList()
                        if !updatedImages.isEmpty {
                            await MainActor.run {
                                state.isFirstLoad = false
                                state.imageListItems.append(contentsOf: updatedImages)
                                state.isLoadMore = false
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            .store(in: &cancellables)

        action.downlodImages
            .sink { url in
                Task(priority: .background) {
                    do {
                        let image = try await self.imageUsecase.getAsyncImage(url)
                        await MainActor.run {
                            cachedImages[url] = image
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            .store(in: &cancellables)

        action.loadMoreImages
            .sink { _ in
                guard !state.isLoadMore else { return }
                
                state.isLoadMore = true
                action.fetchImages.send()
            }
            .store(in: &cancellables)

        action.getImageDetail
            .sink { item in
                var detailItem = self.getImageDetailItem(id: item.id)
                if detailItem == nil {
                    let updatedItem = ImageDetailItem(id: item.id, imageUrl: item.downloadUrl)
                    self.modelContext.insert(updatedItem)
                    do {
                        try self.modelContext.save()
                        detailItem = updatedItem
                    } catch {
                        print("Failed to save changes: \(error)")
                    }
                }
                state.selectedImage = detailItem
            }
            .store(in: &cancellables)
        return state
    }

    private func getImageDetailItem(id: String) -> ImageDetailItem? {
        let predicate = #Predicate<ImageDetailItem> { $0.id == id }

        var fetchDescriptor = FetchDescriptor<ImageDetailItem>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1

        do {
            let images = try modelContext.fetch(fetchDescriptor)
            return images.first
        } catch {
            print("Failed to fetch images with ID \(id): \(error.localizedDescription)")
            return nil
        }
    }
}
