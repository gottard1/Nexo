//
//  UIImageView+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 13/01/25.
//

import UIKit

public extension UIImageView {
    public func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self = placeholder
        
        if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
            self = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            print("URL inválida: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Erro ao baixar a imagem: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Dados inválidos ou não foi possível criar a imagem")
                return
            }
            
            ImageCache.shared.setImage(image, forKey: urlString)
            
            DispatchQueue.main.async {
                self = image
            }
        }.resume()
    }
}
