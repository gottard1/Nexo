//
//  BaseInteractorProtocol.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 08/01/25.
//

import Foundation

public protocol BaseInteractorProtocol {
    func handle<T>(_ apiCall: @escaping () async throws -> T, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public extension BaseInteractorProtocol {
    func handle<T>(_ apiCall: @escaping () async throws -> T, completion: @escaping (Result<T, NetworkError>) -> Void) {
        Task {
            do {
                let result = try await apiCall()
                completion(.success(result))
            } catch let error as NetworkError {
                completion(.failure(error))
            } catch {
                completion(.failure(NetworkError.apiError("Erro desconhecido.")))
            }
        }
    }
}
