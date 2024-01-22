//
//  Service.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import Foundation

public class Service {
    
    private var apiKey: String? {
        Bundle.main.infoDictionary?["IMGUR_API_KEY"] as? String
    }
    
    enum EndPoint {
        case gallery(searchTerm: String)
        
        var scheme: String {
            "https"
        }
        
        var host: String {
            "api.imgur.com"
        }
        
        var path: String {
            "/3/gallery/search"
        }
    }
    
    static let shared = Service()
    
    /// Performs a URL request to fetch more data.
    /// - Parameter endPoint: The EndPoint to perform the network request against.
    /// - Returns: The data type to fetch.
    func fetchData<T: Codable>(from endPoint: EndPoint) async throws -> T? {
        guard let request = urlRequest(endPoint) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = try JSONDecoder().decode(T.self, from: data)
            return json
        } catch {
            print(String(describing: error))
            return nil
        }
    }
    
    /// Creates a URL
    /// - Parameter endPoint: The EndPoint to perform the network request against.
    /// - Returns: Returns the generated URLRequest.
    private func urlRequest(_ endPoint: EndPoint) -> URLRequest? {
        let components = NSURLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.host
        components.path = endPoint.path
        
        switch endPoint {
        case .gallery(let searchTerm):
            components.queryItems = [
                URLQueryItem(name: "q_type", value: "album"),
                URLQueryItem(name: "q_all", value: searchTerm)
            ]
        }
        
        guard let url = components.url,
              let apiKey = apiKey else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(apiKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}

