//
//  LFAdministrativeArea.swift
//  
//
//  Created by 袁林 on 2021/6/19.
//

import Foundation

public struct LFCountry: Equatable, Identifiable {
    public var id = UUID()
    
    public var provinces: [LFProvince] = []
    
    private mutating func secure(_ name: String) {
        if !provinces.contains(where: { $0.name == name }) {
            provinces.append(.init(name: name))
        }
    }
    
    public subscript(province: String) -> LFProvince {
        mutating get {
            secure(province)
            return provinces[provinces.firstIndex(where: { $0.name == province})!]
        }
        set {
            secure(province)
            provinces[provinces.firstIndex(where: { $0.name == province})!] = newValue
        }
    }
    
    public subscript(province: String, city: String) -> LFCity {
        mutating get {
            secure(province)
            return provinces[provinces.firstIndex(where: { $0.name == province})!][city]
        }
        set {
            secure(province)
            provinces[provinces.firstIndex(where: { $0.name == province})!][city] = newValue
        }
    }
    
    public subscript(province: String, city: String, district: String) -> LFDistrict {
        mutating get {
            secure(province)
            return provinces[provinces.firstIndex(where: { $0.name == province})!][city][district]
        }
        set {
            secure(province)
            provinces[provinces.firstIndex(where: { $0.name == province})!][city][district] = newValue
        }
    }
}

public struct LFProvince: Equatable, Identifiable {
    public var id: String { return name }
    
    public let name: String
    public var cities: [LFCity] = []
    
    private mutating func secure(_ name: String) {
        if !cities.contains(where: { $0.name == name }) {
            cities.append(.init(name: name))
        }
    }
    
    public subscript(city: String) -> LFCity {
        mutating get {
            secure(city)
            return cities[cities.firstIndex(where: { $0.name == city})!]
        }
        set {
            secure(city)
            cities[cities.firstIndex(where: { $0.name == city})!] = newValue
        }
    }
    
    public subscript(city: String, district: String) -> LFDistrict {
        mutating get {
            secure(city)
            return cities[cities.firstIndex(where: { $0.name == city})!][district]
        }
        set {
            secure(city)
            cities[cities.firstIndex(where: { $0.name == city})!][district] = newValue
        }
    }
}

public struct LFCity: Equatable, Identifiable {
    public var id: String { return name }
    
    public let name: String
    public var districts: [LFDistrict] = []
    
    private mutating func secure(_ name: String) {
        if !districts.contains(where: { $0.name == name }) {
            districts.append(.init(name: name))
        }
    }
    
    public subscript(district: String) -> LFDistrict {
        mutating get {
            secure(district)
            return districts[districts.firstIndex(where: { $0.name == district})!]
        }
        set {
            secure(district)
            districts[districts.firstIndex(where: { $0.name == district})!] = newValue
        }
    }
}

public struct LFDistrict: Equatable, Identifiable {
    public var id: String { return name }
    
    public let name: String
    public var content: LFContent = .init()
}


public struct LFContent: Equatable, Identifiable {
    public var id: Int { return code }
    
    public var code: Int = 0
    public var formattedAddress: String = ""
    public var coordinate: LFCoordinate = .defaultCoordinate
    
    public static let defaultContent = LFContent()
    
}

extension LFContent {
    init(from locality: LFLocality) {
        self.init(code: locality.code, formattedAddress: locality.formattedAddress, coordinate: locality.coordinate)
    }
}
