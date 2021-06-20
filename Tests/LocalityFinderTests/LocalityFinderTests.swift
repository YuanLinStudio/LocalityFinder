    import XCTest
    @testable import LocalityFinder
    
    final class LocalityFinderTests: XCTestCase {
        
        func testEqual() {
            let content = LFFinder().structuredContent["河南省"]["郑州市"]["上街区"].content
            print(content)
            XCTAssertEqual(content.code, 410106)
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
            let content1 = LFFinder().structuredContent["河南省"]["郑州市"]["上街区"].content
            let content2 = LFFinder().structuredContent["河南省", "郑州市", "上街区"].content
            
            XCTAssertEqual(content1, content2)
        }
    }
