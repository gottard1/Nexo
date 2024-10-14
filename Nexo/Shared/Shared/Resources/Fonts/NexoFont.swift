//
//  NexoFont.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 14/10/24.
//

import UIKit

public struct NexoFont {
    
    public enum Exo2Type: String {
        case regular = "Exo2-Light"
        case bold = "Exo2-Bold"
    }
    
    public enum OpenSansType: String {
        case regular = "OpenSans-Light"
        case bold = "OpenSans-Bold"
        case semibold = "OpenSans-SemiBold"
    }
    
    public static func exo2Font(ofType type: Exo2Type, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func openSansFont(ofType type: OpenSansType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
