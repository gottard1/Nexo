//
//  HomeService.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Shared
import UIKit

protocol HomeServiceProtocol {
    func fetchHome(parameters: HomeDataRequest) async throws -> [SDUIComponent]
}

class HomeService: HomeServiceProtocol {
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func fetchHome(parameters: HomeDataRequest) async throws -> [SDUIComponent] {
        let endpoint = HomeTarget.fetchHome(object: parameters)
        let response: [SDUIComponent] = try await networkManager.request(
            target: endpoint,
            responseType: [SDUIComponent].self
        )
        return response
    }
}
