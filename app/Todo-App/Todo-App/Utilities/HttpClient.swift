//
//  HttpClient.swift
//  Todo-App
//
//  Created by Martin Peth on 20.06.22.
//

import Foundation

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

enum HttpMethods: String {
    case POST, GET, PUT, DELETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
}

class HttpClient{
    static let instance = HttpClient()
    
    private init() {}
    
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        print(data)
        print(response)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw HttpError.errorDecodingData
        }
        
        return object
    }
    
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        print(request.httpBody)
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
