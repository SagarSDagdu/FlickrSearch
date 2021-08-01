//
//  TestsJsonUtil.swift
//  FlickrSearchTests
//
//  Created by Sagar Dagdu on 01/08/21.
//

import Foundation

final class TestUtils {
    static func dataFromFile(name: String, ofType type: String) -> Data {
        guard let pathString = Bundle(for: Photo_Tests.self).path(forResource: name, ofType: type) else {
            fatalError("\(name).\(type) not found")
        }

        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: pathString)) else {
            fatalError("Unable to convert \(name).\(type) to data")
        }

        return jsonData
    }
}
