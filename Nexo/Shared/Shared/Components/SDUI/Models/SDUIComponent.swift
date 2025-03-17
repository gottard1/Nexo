//
//  SDUIComponent.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

public struct SDUIComponentData: Codable {
    let componentType: ComponentType
    let data: Codable
    let config: SDUIConfig?
    
    init<T: SDUIComponentModel>(model: T, config: SDUIConfig? = nil) {
        self.componentType = T.type
        self.data = model
        self.config = config
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.componentType = try container.decode(ComponentType.self, forKey: .componentType)
        self.config = try container.decodeIfPresent(SDUIConfig.self, forKey: .config)
        
        if let modelType = ComponentMapper.componentMap[componentType] {
            let data = try container.decode(modelType, forKey: .data)
            self.data = data
        } else {
            throw DecodingError.dataCorruptedError(forKey: .componentType, in: container, debugDescription: "Tipo de componente desconhecido")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(componentType, forKey: .componentType)
        try data.encode(to: encoder)
        try container.encodeIfPresent(config, forKey: .config)
    }
    
    enum CodingKeys: String, CodingKey {
        case componentType = "component_type"
        case data
        case config
    }
}
