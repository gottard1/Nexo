//
//  NexoTabBarItemModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/10/24.
//

import UIKit

enum NexoTabBarItemModel: CaseIterable {
    case home
    case extract
    case card
    case services
    
    var title: String {
        switch self {
            case .home:
                return "Home"
            case .extract:
                return "Extrato"
            case .card:
                return "Cartão"
            case .services:
                return "Serviços"
        }
    }
    
    var image: UIImage {
        switch self {
            case .home:
                return UIImage(systemName: "pencil") ?? UIImage() // TODO: - CHANGE IMAGE
            case .extract:
                return UIImage(systemName: "highlighter") ?? UIImage() // TODO: - CHANGE IMAGE
            case .card:
                return UIImage(systemName: "eraser") ?? UIImage() // TODO: - CHANGE IMAGE
            case .services:
                return UIImage(systemName: "scribble") ?? UIImage() // TODO: - CHANGE IMAGE
        }
    }
}
