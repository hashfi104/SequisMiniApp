//
//  NetworkResultType.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/10/26.
//

import Foundation

enum NetworkResultType<T: Codable> {
    case success(T)
    case successArray([T])
    case failure(Error)
}
