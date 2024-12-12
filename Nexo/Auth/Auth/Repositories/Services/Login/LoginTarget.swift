//
//  LoginTarget.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 08/11/24.
//

import Shared
import Foundation

enum LoginTarget {
    case authenticate(object: AuthenticateRequest)
}

extension LoginTarget: BaseTarget {
    
    var path: String {
        switch self {
            case .authenticate:
                return AuthEndpointsModel.login
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .authenticate:
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
            case .authenticate(let credentials):
                return try? JSONEncoder().encode(credentials)
        }
    }
    
}
