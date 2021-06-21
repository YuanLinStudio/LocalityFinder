//
//  LFLocalityPickerViewModel.swift
//  
//
//  Created by 袁林 on 2021/6/21.
//

import Foundation
import OrderedDictionary


@available(iOS 14.0, macOS 11.0, *)
public class LFLocalityPickerViewModel: ObservableObject {
    
    let localitiesDictionary = LFFinder().localitiesDictionary
    
    @Published var displayLevel: DisplayLevel = .inactive
    
    @Published var district: LFLocality
    
    @Published var province: OrderedDictionary<String, OrderedDictionary<String, LFLocality>> {
        didSet {
            city = province.first!.value
            if displayLevel == .province {
                if province.orderedKeys.count == 1 {
                    displayLevel = .district
                }
                else {
                    displayLevel = .city
                }
            }
        }
    }
    @Published var city: OrderedDictionary<String, LFLocality> {
        didSet {
            district = city.first!.value
            if displayLevel == .city {
                displayLevel = .district
            }
        }
    }
    
    init(locality: LFLocality = .defaultLocality) {
        self.district = locality
        self.province = localitiesDictionary[locality.province]!
        self.city = localitiesDictionary[locality.province]![locality.city]!
    }
}

@available(iOS 14.0, macOS 11.0, *)
extension LFLocalityPickerViewModel {
    public enum DisplayLevel: Int, Comparable, Equatable {
        case inactive = -1
        case active = 0
        case province = 1
        case city = 2
        case district = 3
        
        public static func < (lhs: DisplayLevel, rhs: DisplayLevel) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
        var isActive: Bool {
            get { return self != .inactive }
            set {
                if newValue { self = .active }
                else { self = .inactive }
            }
        }
    }
}

