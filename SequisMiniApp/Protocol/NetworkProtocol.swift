//
//  NetworkProtocol.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/10/26.
//

protocol NetworkManagerProtocol {
    func startRequest<T: Codable>(
        urlString: String,
        method: RequestMethod,
        headers: [String:String]?,
        requestBody: Codable?,
        isArrayResult: Bool
    ) async throws -> NetworkResultType<T>
}
