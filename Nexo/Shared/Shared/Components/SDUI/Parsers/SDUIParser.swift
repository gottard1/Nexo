//
//  SDUIParser.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

class SDUIParser {
    func parse(jsonData: Data) -> SDUIBuilder? {
        let decoder = JSONDecoder()
        do {
            let builder = try decoder.decode(SDUIBuilder.self, from: jsonData)
            return builder
        } catch {
            print("Erro ao decodificar SDUIBuilder: \(error)")
            return nil
        }
    }
}
