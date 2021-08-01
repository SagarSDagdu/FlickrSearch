//
//  Photo_Tests.swift
//  FlickrSearchTests
//
//  Created by Sagar Dagdu on 01/08/21.
//

import XCTest
import Foundation

@testable import FlickrSearch

class Photo_Tests: XCTestCase {
    
    var mockJsonData: Data?
    
    override func setUp() {
        super.setUp()
        
        mockJsonData = TestUtils.dataFromFile(name: "photo_mock_data", ofType: "json")
    }
    
    func test_jsonDecoding() {
        do {
            let decoder = JSONDecoder()
            let photo = try decoder.decode(Photo.self, from: mockJsonData!)
            XCTAssertEqual(photo.id, "51341779144")
            XCTAssertEqual(photo.isPublic, 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
