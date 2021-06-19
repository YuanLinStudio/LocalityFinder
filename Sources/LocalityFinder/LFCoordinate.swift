//
//  LFCoordinate.swift
//  
//
//  Created by 袁林 on 2021/6/19.
//

import Foundation
import CoreLocation

public typealias LFCoordinate = CLLocationCoordinate2D

extension LFCoordinate {
    public init(longitude: Double, latitude: Double) {
        self.init(latitude: latitude, longitude: longitude)
    }
    
    /// String used in API request.
    var urlString: String { return String(format: "%.4f,%.4f", longitude, latitude) }
    
    /// 默认坐标位置（经纬度均为 0）
    public static let defaultCoordinate = LFCoordinate(longitude: .zero, latitude: .zero)
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "lng"
        case latitude = "lat"
    }
}

extension LFCoordinate: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        
        self.init(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

extension LFCoordinate: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
