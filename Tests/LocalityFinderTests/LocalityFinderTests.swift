    import XCTest
    @testable import LocalityFinder

    final class LocalityFinderTests: XCTestCase {
        
        func testLoad() {
            let expectation = self.expectation(description: "request")
            var testData: Data?
            var testError: Error?
            
            let request = LFRequest()
            request.loadData { data, error in
                testData = data
                testError = error
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNotNil(testData)
            XCTAssertNil(testError)
        }
        
        func testDecode() {
            let expectation = self.expectation(description: "response")
            var testResponse: LFResponse?
            var testError: Error?
            var testContent: Int?
            
            let request = LFRequest()
            
            request.loadData { data, error in
                request.decode(data!) { response, error in
                    testResponse = response
                    testError = error
                    testContent = response?.localities[0].code
                    expectation.fulfill()
                }
            }
            
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNil(testError)
            XCTAssertNotNil(testResponse)
            XCTAssertEqual(testContent!, 110000)
            
        }
    }
