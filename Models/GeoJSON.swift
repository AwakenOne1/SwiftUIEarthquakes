//
//  GeoJSON.swift
//  SwiftUIEarthquakes
//
//  Created by Alexey Dubovik on 13.02.24.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    
    private(set) var quakes: [Quake] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featuresContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featuresContainer.isAtEnd {
            let propertiesContainers = try featuresContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            
            if let properties = try? propertiesContainers.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}
