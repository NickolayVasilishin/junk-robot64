import XCTest
@testable import junk_robot64_ios

class EndpointsTests: XCTestCase {

    func testMakeURL_simpleEndpoint_shouldReturnCorrectURL() {
        let endpoint = "test"

        let expectedURL = URL(string: "http://10.100.31.96:9999/test")!
        let result = Endpoints.makeURL(endpoint: endpoint)

        XCTAssertEqual(result, expectedURL)
    }

}
