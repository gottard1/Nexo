//
//  RegisterTarget.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 18/12/24.
//

import Shared
import Foundation

enum RegisterTarget {
    case validateCode(code: ValidateCodeModel)
    case register(user: RegisterModel)
}

extension RegisterTarget: BaseTarget {
    
    var path: String {
        switch self {
            case .validateCode:
                return AuthEndpointsModel.validateCode
            case .register:
                return AuthEndpointsModel.register
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .validateCode, .register:
                return .post
        }
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
    
    var body: Data? {
        switch self {
            case .validateCode(let code):
                return try? JSONEncoder().encode(code)
            case .register(let model):
                return try? JSONEncoder().encode(model)
        }
    }
    
}
