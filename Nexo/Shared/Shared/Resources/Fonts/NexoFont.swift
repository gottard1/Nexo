//
//  NexoFont.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 14/10/24.
//

import UIKit

public final class NexoFont {
    
    public enum Exo2Type: String {
        case regular
        case bold
        
        public var fontName: String {
            switch self {
                case .regular:
                    return "Exo2-Light"
                case .bold:
                    return "Exo2-Bold"
            }
        }
    }
    
    public enum OpenSansType: String {
        case regular
        case semibold
        case bold
        
        public var fontName: String {
            switch self {
                case .regular:
                    return "OpenSans-Light"
                case .semibold:
                    return "OpenSans-SemiBold"
                case .bold:
                    return "OpenSans-Bold"
            }
        }
    }
    
    public static func exo2Font(ofType type: Exo2Type, size: CGFloat) -> UIFont {
        return UIFont(name: type.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func openSansFont(ofType type: OpenSansType, size: CGFloat) -> UIFont {
        return UIFont(name: type.fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension NexoFont {
    
    public static func registerFonts() {
        let fontNames = [
            "Exo2-Bold",
            "Exo2-Light",
            "OpenSans-SemiBold",
            "OpenSans-Bold",
            "OpenSans-Light.ttf"
        ]
        fontNames.forEach {
            registerFont(bundle: .shared, fontName: $0, fontExtension: "ttf")
        }
    }
    
    fileprivate static func registerFont(bundle: Bundle?, fontName: String, fontExtension: String) {
        guard let fontURL = bundle?.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else { return }
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
