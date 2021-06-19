//
//  LFResponse.swift
//  
//
//  Created by 袁林 on 2021/6/19.
//

import Foundation

public struct LFResponse: Codable, Equatable {
    public let localities: [LFLocality]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        localities = try container.decode([LFLocality].self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(localities)
    }
}
