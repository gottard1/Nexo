//
//  Bundle+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/09/24.
//

import Foundation

public extension Bundle {
    /// Retorna o `Bundle` associado ao módulo Shared.
    static var shared: Bundle? {
        return Bundle(identifier: "com.br.Nexo.Shared")
    }
}
