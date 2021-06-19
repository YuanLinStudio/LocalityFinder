//
//  LFRequest.swift
//  
//
//  Created by 袁林 on 2021/6/19.
//

import Foundation

public class LFRequest {
    
    /// The queue on which the request is performed
    public var queue: DispatchQueue = .global(qos: .background)
    
    /// Load data from `resource`.
    public func loadData(completionHandler: @escaping (Data?, Error?) -> Void) {
        queue.async {
            guard let url = Bundle.module.url(forResource: "Localities", withExtension: "json") else {
                completionHandler(nil, LFError.fileDontExist)
                return
            }
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                completionHandler(data, nil)
                NSLog("Reading example data. URL: %@", url.absoluteString)
            }
            catch let error {
                completionHandler(nil, error)
                NSLog("Error exists when reading example data. Error: %@", error.localizedDescription)
            }
        }
    }
    
    /// Decode the data. May result in `DFLocality`, or cannot decode.
    public func decode(_ data: Data, completionHandler: @escaping (LFResponse?, LFError?) -> Void) {
        queue.async {
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(LFResponse.self, from: data) {
                completionHandler(response, nil)
                NSLog("Successfully decode content.", 0)
            }
            else {
                completionHandler(nil, .invalidResponse)
                NSLog("API return unexpected result", -1)
            }
        }
    }
    
    
}
