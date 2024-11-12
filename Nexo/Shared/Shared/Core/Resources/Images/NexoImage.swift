//
//  NexoImage.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/09/24.
//

import UIKit

public final class NexoImage {
    // Exemplo de uma função auxiliar para carregar imagens do Shared Bundle
    private static func loadImage(named name: String) -> UIImage? {
        return UIImage(named: name, in: .shared, compatibleWith: nil)
    }
    
    // Exemplo de imagens
    static var logo: UIImage? { return loadImage(named: "logo") }
    static var iconProfile: UIImage? { return loadImage(named: "iconProfile") }
    static var backgroundPattern: UIImage? { return loadImage(named: "backgroundPattern") }
    
    // Outros exemplos de imagens categorizadas
    // Você pode criar diferentes seções assim como as cores
    static var buttonImage: UIImage? { return loadImage(named: "buttonImage") }
    static var splashScreen: UIImage? { return loadImage(named: "splashScreen") }
    
    // Gray scale (caso tenha imagens)
    static var grayImage1: UIImage? { return loadImage(named: "grayImage1") }
    static var grayImage2: UIImage? { return loadImage(named: "grayImage2") }
}
