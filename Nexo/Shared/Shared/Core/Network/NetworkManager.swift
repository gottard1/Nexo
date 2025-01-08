//
//  NetworkManager.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/10/24.
//

import Foundation

public protocol Networking {
    func request<T: Decodable>(target: BaseTarget, responseType: T.Type) async throws -> T
}

public final class NetworkManager: Networking {
    private let baseURL: String = "http://127.0.0.1:5000"
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(target: BaseTarget, responseType: T.Type) async throws -> T {
        guard let base = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        let fullURL = base.appendingPathComponent(target.path)
        var urlComponents = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        
        if target.method == .get, let queryParameters = target.body {
            if let queryDict = try? JSONSerialization.jsonObject(with: queryParameters, options: []) as? [String: Any] {
                urlComponents?.queryItems = queryDict.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
        }
        
        guard let url = urlComponents?.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method.rawValue
        urlRequest.allHTTPHeaderFields = target.headers
        urlRequest.httpBody = target.method == .get ? nil : target.body
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                throw NetworkError.statusCode(httpResponse.statusCode, errorMessage?.message ?? "Erro desconhecido.")
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
            
        } catch let networkError as NetworkError {
            throw networkError
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingError(decodingError)
        } catch {
            throw NetworkError.apiError(error.localizedDescription)
        }
    }
}
