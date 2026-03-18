//
//  ImageDownloadUsecase.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/17/26.
//

import SwiftUI

protocol ImageDownloadUsecaseProtocol {
    func getAsyncImage(_ urlString: String) async throws -> Image?
}

final class ImageDownloadUsecase: ImageDownloadUsecaseProtocol {
    let repository: ImageDownloadRepositoryProtocol

    public init(repository: ImageDownloadRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getAsyncImage(_ urlString: String) async throws -> Image? {
        try await repository.getImage(urlString: urlString)
    }
}
