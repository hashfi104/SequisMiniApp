//
//  ImageResponse.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/11/26.
//

struct ImageListItemResponse: Codable, Identifiable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let downloadUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }

    func mappingToEntity() -> ImageListItemEntity {
        ImageListItemEntity(
            id: id ?? "", author: author ?? "", downloadUrl: downloadUrl ?? ""
        )
    }
}
