//
//  Double+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 26/01/25.
//

import UIKit

public extension Double {
    /// Exemplo de saída: "R$ 1.500,00"
    public var toCurrencyBRL: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "R$ 0,00"
    }
}
