    import XCTest
    @testable import LocalityFinder
    
    final class LocalityFinderTests: XCTestCase {
        
        func testEqual() {
            let locality = LFFinder().structuredDictionary["河南省"]!["郑州市"]!["上街区"]!
            print(locality)
            XCTAssertEqual(locality.code, 410106)
        }
        
        func testProvince() {
            let provinces = LFFinder().structuredDictionary.orderedKeys
            print(provinces)
            //print(provinces.map { $0.name })
            XCTAssertTrue(provinces.contains { $0 == "河南省" })
        }
        
        func testCities() {
            let cities = LFFinder().structuredDictionary["河南省"]!.orderedKeys
            print(cities)
            //print(cities.map { $0.name })
            XCTAssertTrue(cities.contains { $0 == "开封市" })
        }
        
        func testDistricts() {
            let districts = LFFinder().structuredDictionary["河南省"]!["郑州市"]!.orderedKeys
            print(districts)
            //print(districts.map { $0.name })
            XCTAssertTrue(districts.contains { $0 == "荥阳市" })
        }
        
        func testAbbriable() {
            //let locality1 = LFFinder().structuredDictionary["河南省"]!["郑州市"]!["上街区"]!
            //let locality2 = LFFinder().structuredDictionary["河南省", "郑州市", "上街区"]
            
            //XCTAssertEqual(locality1, locality2)
            //XCTAssertEqual(locality1.code, locality2.code)
        }
    }
