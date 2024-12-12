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
    public static var registerInitial: UIImage? { return loadImage(named: "registerInitial") }
}
