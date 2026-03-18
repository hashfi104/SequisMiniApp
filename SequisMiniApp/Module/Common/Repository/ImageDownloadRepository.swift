//
//  ImageDownloadRepository.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/17/26.
//

import SwiftUI

protocol ImageDownloadRepositoryProtocol {
    func getImage(urlString: String) async throws -> Image?
}

final class ImageDownloadRepository: ImageDownloadRepositoryProtocol {
    public func getImage(urlString: String) async throws -> Image? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return Image(uiImage: UIImage(data: data) ?? UIImage())
        } catch {
            return nil
        }
    }
}
