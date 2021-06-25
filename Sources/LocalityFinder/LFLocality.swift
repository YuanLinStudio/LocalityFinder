//
//  LFLocality.swift
//  
//
//  Created by 袁林 on 2021/6/19.
//

import Foundation

public struct LFLocality: Codable, Equatable, Identifiable, Hashable {
    
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
    
    public init(province: String, city: String, district: String, code: Int, formattedAddress: String, coordinate: LFCoordinate) {
        self.province = province
        self.city = city
        self.district = district
        self.code = code
        self.formattedAddress = formattedAddress
        self.coordinate = coordinate
    }
}

extension LFLocality {
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

extension LFLocality {
    public static let defaultLocality: LFLocality = LFLocality(province: "上海市", city: "上海市", district: "闵行区", code: 310112, formattedAddress: "上海交通大学闵行校区", coordinate: .init(latitude: 31.025785475418274, longitude: 121.4474754473953))
}
