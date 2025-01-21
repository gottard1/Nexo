//
//  HomeTarget.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Shared

enum HomeTarget {
    case fetchHome(document: String)
    case organizeHome(object: SDUIBuilder)
}

extension HomeTarget: BaseTarget {
    
    var path: String {
        switch self {
            case .fetchHome:
                return HomeEndpointsModel.components
            case .organizeHome:
                return HomeEndpointsModel.components
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
            case .fetchHome(let document):
                return ["cpf_cnpj": document]
            default:
                return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .fetchHome:
                return .get
            case .organizeHome:
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
            case .organizeHome(let body):
                return try? JSONEncoder().encode(body)
            default:
                return nil
        }
    }
}
