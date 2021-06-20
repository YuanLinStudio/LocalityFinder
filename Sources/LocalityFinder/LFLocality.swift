//
//  LFLocality.swift
//  
//
//  Created by 袁林 on 2021/6/19.
//

import Foundation

public struct LFLocality: Codable, Equatable, Identifiable {
    public let id = UUID()
    
    public let province: String
    public let city: String
    public let district: String
    public let code: Int
    public let formattedAddress: String
    public let coordinate: LFCoordinate
    
    private enum CodingKeys: String, CodingKey {
        case province
        case city
        case district
        case code = "adcode"
        case formattedAddress = "formatted_address"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        province = try container.decode(String.self, forKey: .province)
        city = try container.decode(String.self, forKey: .city)
        district = try container.decode(String.self, forKey: .district)
        code = try container.decode(Int.self, forKey: .code)
        formattedAddress = try container.decode(String.self, forKey: .formattedAddress)
        
        coordinate = try .init(from: decoder)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(province, forKey: .province)
        try container.encode(city, forKey: .city)
        try container.encode(district, forKey: .district)
        try container.encode(code, forKey: .code)
        try container.encode(formattedAddress, forKey: .formattedAddress)
        
        try coordinate.encode(to: encoder)
    }
}
