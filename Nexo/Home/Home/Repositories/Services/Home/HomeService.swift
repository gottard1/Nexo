//
//  HomeService.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Shared
import UIKit

protocol HomeServiceProtocol {
    func fetchHome() async throws -> SDUIBuilder
}

class HomeService: HomeServiceProtocol {
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func fetchHome() async throws -> SDUIBuilder {
        let document = "07960046921"
        let endpoint = HomeTarget.fetchHome(document: document)
        let response: SDUIBuilder = try await networkManager.request(
            target: endpoint,
            responseType: SDUIBuilder.self
        )
        return response
    }
}
