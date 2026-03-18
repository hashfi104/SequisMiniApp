//
//  ImageListUsecase.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/16/26.
//

protocol ImageListUsecaseProtocol {
    func fetchImageList() async throws -> [ImageListItemEntity]
}

class ImageListUsecase: ImageListUsecaseProtocol {
    var networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchImageList() async throws -> [ImageListItemEntity] {
        do {
            let result: NetworkResultType<ImageListItemResponse> = try await networkManager.startRequest(
                urlString: "https://picsum.photos/v2/list",
                method: .GET,
                headers: nil,
                requestBody: nil,
                isArrayResult: true
            )
            switch result {
            case .successArray(let images):
                return images.map { $0.mappingToEntity() }
            default:
                return []
            }
        }
    }
}
