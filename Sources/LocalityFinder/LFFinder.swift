//
//  LFFinder.swift
//  
//
//  Created by 袁林 on 2021/6/19.
//

import Foundation
import OrderedDictionary

public typealias LFAdministrativeArea<T> = OrderedDictionary<String, T>
public typealias LFDistrict = LFLocality
public typealias LFCity = LFAdministrativeArea<LFDistrict>
public typealias LFProvince = LFAdministrativeArea<LFCity>

public class LFFinder {
    /// 全部的地区地市
    public lazy var allLocalities: [LFLocality] = getLocalities()
    
    /// 按照`localitiesDictionary[province][city][district]`访问数据
    public lazy var localitiesDictionary: OrderedDictionary<String, OrderedDictionary<String, OrderedDictionary<String, LFLocality>>> = {
        var dictionary = OrderedDictionary<String, OrderedDictionary<String, OrderedDictionary<String, LFLocality>>>()
        
        let localities = getLocalities().filter { $0.province != "" && $0.city != "" && $0.district != "" }
        
        for locality in localities {
            if dictionary[locality.province] == nil {
                dictionary[locality.province] = .init()
            }
            if dictionary[locality.province]![locality.city] == nil {
                dictionary[locality.province]![locality.city] = .init()
            }
            dictionary[locality.province]![locality.city]![locality.district] = locality
        }
        return dictionary
    }()
    
    public init() { }
}

fileprivate func getLocalities() -> [LFLocality] {
    let data = loadData()
    let response = decode(data)
    return response!.localities
}

fileprivate func loadData() -> Data? {
    guard let url = Bundle.module.url(forResource: "Localities", withExtension: "json"), let data = try? Data(contentsOf: url, options: .mappedIfSafe) else { return nil }
    return data
}

fileprivate func decode(_ data: Data?) -> LFResponse? {
    guard let data = data else { return nil }
    let decoder = JSONDecoder()
    guard let response = try? decoder.decode(LFResponse.self, from: data) else { return nil }
    return response
}
