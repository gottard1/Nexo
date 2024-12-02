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
    
    public static var onboarding: UIImage? { return loadImage(named: "onboarding") }
    
    
    // Exemplo de imagens
    public static var logo: UIImage? { return loadImage(named: "logo") }
    public static var iconProfile: UIImage? { return loadImage(named: "iconProfile") }
    public static var backgroundPattern: UIImage? { return loadImage(named: "backgroundPattern") }
    
    // Outros exemplos de imagens categorizadas
    // Você pode criar diferentes seções assim como as cores
    public static var buttonImage: UIImage? { return loadImage(named: "buttonImage") }
    public static var splashScreen: UIImage? { return loadImage(named: "splashScreen") }
    
    // Gray scale (caso tenha imagens)
    public static var grayImage1: UIImage? { return loadImage(named: "grayImage1") }
    public static var grayImage2: UIImage? { return loadImage(named: "grayImage2") }
}
