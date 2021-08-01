//
//  FlickrApiResponse_Tests.swift
//  FlickrSearchTests
//
//  Created by Sagar Dagdu on 01/08/21.
//

import XCTest
@testable import FlickrSearch

class FlickrApiResponse_Tests: XCTestCase {
    
    var mockJsonData: Data?
    
    override func setUp() {
        super.setUp()
        
        mockJsonData = TestUtils.dataFromFile(name: "flickr_api_mock_data", ofType: "json")
    }
    
    func test_jsonDecoding() {
        do {
            let decoder = JSONDecoder()
            let photo = try decoder.decode(FlickrApiResponse.self, from: mockJsonData!)
            XCTAssertEqual(photo.photos?.photoCollection?.count, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
