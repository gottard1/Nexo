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
            case .fetchHome(let document):
                // Adicione o cpf_cnpj ao caminho
                return "\(HomeEndpointsModel.components)?cpf_cnpj=\(document)"
            case .organizeHome:
                return HomeEndpointsModel.components
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
            case .fetchHome:
                return nil
            case .organizeHome(let body):
                return try? JSONEncoder().encode(body)
        }
    }
}
