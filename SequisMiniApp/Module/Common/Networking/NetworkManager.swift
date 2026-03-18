//
//  NetworkManager.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/10/26.
//

import Foundation
import Combine

class NetworkManager: ObservableObject, NetworkManagerProtocol {
    func startRequest<T>(
        urlString: String,
        method: RequestMethod,
        headers: [String : String]?,
        requestBody: Codable?,
        isArrayResult: Bool
    ) async throws -> NetworkResultType<T> where T : Decodable, T : Encodable {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "URL not found", code: 404, userInfo: nil)
            return .failure(error)
        }

        // Request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Headers
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        } else {
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
        }

        // Checking Method
        if method != .GET {
            // Request Body
            let encoder = JSONEncoder()
            do {
                if let body = requestBody {
                    let jsonData = try encoder.encode(body)
                    // Checking Header Content-Type
                    if let headers = request.allHTTPHeaderFields {
                        let headerContentType = headers["Content-Type"]
                        switch headerContentType {
                        case "application/x-www-form-urlencoded":
                            var dataString = ""
                            if let object = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                object.forEach({ (key, value) in
                                    dataString += "\(key)=\(value)&"
                                })
                                dataString.removeLast()
                            }
                            
                            // Declare Data
                            let data = dataString.data(using: .ascii, allowLossyConversion: false)
                            request.httpBody = data
                        default:
                            request.httpBody = jsonData
                        }
                    }
                }
            } catch let error {
                return .failure(error)
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let error = NSError(
                domain: "Request Failed",
                code: (response as? HTTPURLResponse)?.statusCode ?? 0,
                userInfo: nil
            )
            return .failure(error)
        }

        do {
            if isArrayResult {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                return .successArray(decodedData)
            }
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch let error {
            return .failure(error)
        }
    }
}
