//
//  ImageDetailItem.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/17/26.
//

import Foundation
import SwiftData

@Model
final class ImageDetailItem {
    var id: String
    var imageUrl: String
    var comments: [ImageDetailItemComment]

    init(id: String, imageUrl: String, comments: [ImageDetailItemComment] = []) {
        self.id = id
        self.imageUrl = imageUrl
        self.comments = comments
    }
}

@Model
final class ImageDetailItemComment {
    var name: String
    var detail: String
    var timestamp: Date

    init(name: String, detail: String, timestamp: Date) {
        self.name = name
        self.detail = detail
        self.timestamp = timestamp
    }
}
