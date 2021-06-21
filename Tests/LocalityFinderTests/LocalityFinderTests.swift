    import XCTest
    @testable import LocalityFinder
    
    final class LocalityFinderTests: XCTestCase {
        
        func testEqual() {
            let locality = LFFinder().structuredContent["河南省"]["郑州市"]["上街区"].locality
            print(locality)
            XCTAssertEqual(locality.code, 410106)
        }
        
        func testProvince() {
            let provinces = LFFinder().structuredContent.provinces
            print(provinces.map { $0.name })
            XCTAssertTrue(provinces.contains { $0.name == "河南省" })
        }
        
        func testCities() {
            let cities = LFFinder().structuredContent["河南省"].cities
            print(cities.map { $0.name })
            XCTAssertTrue(cities.contains { $0.name == "开封市" })
        }
        
        func testDistricts() {
            let districts = LFFinder().structuredContent["河南省"]["郑州市"].districts
            print(districts.map { $0.name })
            XCTAssertTrue(districts.contains { $0.name == "荥阳市" })
        }
        
        func testAbbriable() {
            let locality1 = LFFinder().structuredContent["河南省"]["郑州市"]["上街区"].locality
            let locality2 = LFFinder().structuredContent["河南省", "郑州市", "上街区"].locality
            
            //XCTAssertEqual(locality1, locality2)
            XCTAssertEqual(locality1.code, locality2.code)
        }
    }
