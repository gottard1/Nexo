//
//  String+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 09/12/24.
//

import UIKit

public enum MaskFormatterType: String {
    case cpf = "###.###.###-##"
    case cnpj = "##.###.###/####-##"
    case phone = "(##) #####-####"
    case internationalPhone = "(###) #####-####"
}

extension String {
    public var loadColor: UIColor {
        NexoColor.loadColor(named: self)
    }
}

extension String {
    public var onlyDigits: String {
        return self.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
    }
    
    public var isValidCPFOrCNPJ: Bool {
        let digits = self.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        
        if digits.count == 11 {
            return self.isValidCPF
        } else if digits.count == 14 {
            return self.isValidCNPJ
        }
        return false
    }
    
    public var isValidEmail: Bool {
        let regexText = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,}+(\\.[A-Za-z]{2,})*"
        return NSPredicate(format: "SELF MATCHES %@", regexText).evaluate(with: self)
    }
    
    public var isValidPassword: Bool {
        let specialCharacterRegex = ".*[^A-Za-z0-9].*"
        let containsSpecialCharacter = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: self)
        
        let uppercaseLetterRegex = ".*[A-Z].*"
        let containsUppercaseLetter = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: self)
        
        let numberRegex = ".*[0-9].*"
        let containsNumber = NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: self)
        
        return containsSpecialCharacter && containsUppercaseLetter && containsNumber
    }
    
    public func formatText(using mask: MaskFormatterType) -> String {
        let pattern = mask.rawValue
        let patternArray = Array(pattern)
        
        var text = self.filter { $0.isNumber }
        
        if text.count > pattern.count {
            text = String(text.prefix(pattern.count))
        }
        
        var formattedText = ""
        var textIndex = text.startIndex
        
        for char in patternArray {
            if char == "#", textIndex < text.endIndex {
                formattedText.append(text[textIndex])
                textIndex = text.index(after: textIndex)
            } else if char != "#" {
                formattedText.append(char)
            }
        }
        
        return formattedText
    }
}

// MARK: - Validators
private extension String {
    
    private var isValidCPF: Bool {
        let digits = self.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        
        guard digits.count == 11 else { return false }
        
        let sameDigitPattern = Set(digits)
        guard sameDigitPattern.count > 1 else { return false }
        
        let firstVerifier = calculateVerifier(digits: digits, length: 9, weights: Array(stride(from: 10, through: 2, by: -1)))
        let secondVerifier = calculateVerifier(digits: digits, length: 10, weights: Array(stride(from: 11, through: 2, by: -1)))
        
        guard let firstVerifierChar = Int(String(digits[digits.index(digits.startIndex, offsetBy: 9)])),
              let secondVerifierChar = Int(String(digits[digits.index(digits.startIndex, offsetBy: 10)])),
              firstVerifier == firstVerifierChar,
              secondVerifier == secondVerifierChar else { return false }
        
        return true
    }
    
    private var isValidCNPJ: Bool {
        let digits = self.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        
        guard digits.count == 14 else { return false }
        
        let sameDigitPattern = Set(digits)
        guard sameDigitPattern.count > 1 else { return false }
        
        let firstVerifier = calculateVerifier(digits: digits, length: 12, weights: [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])
        
        guard let firstVerifierChar = Int(String(digits[digits.index(digits.startIndex, offsetBy: 12)])),
              firstVerifier == firstVerifierChar else { return false }
        
        let secondVerifier = calculateVerifier(digits: digits, length: 13, weights: [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])
        
        guard let secondVerifierChar = Int(String(digits[digits.index(digits.startIndex, offsetBy: 13)])),
              secondVerifier == secondVerifierChar else { return false }
        
        return true
    }
    
    private func calculateVerifier(digits: String, length: Int, weights: [Int]) -> Int {
        let numbers = digits.prefix(length).compactMap { Int(String($0)) }
        let sum = zip(numbers, weights).reduce(0) { $0 + $1.0 * $1.1 }
        let remainder = sum % 11
        return remainder < 2 ? 0 : 11 - remainder
    }
    
}
