//
//  HomeTarget.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Shared

enum HomeTarget {
    case fetchHome(object: HomeDataRequest)
}

extension HomeTarget: BaseTarget {
    
    var path: String {
        switch self {
            case .fetchHome:
                return HomeEndpointsModel.buildHome
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .fetchHome:
                return .post
        }
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    var body: Data? {
        switch self {
            case .fetchHome(let parameters):
                return try? JSONEncoder().encode(parameters)
        }
    }
    
}
