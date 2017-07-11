//
//  ManyImagesSnapshots.swift
//  itauempresas
//
//  Created by Mariana Alvarez on 7/11/17.
//  Copyright © 2017 Itau. All rights reserved.
//

import Foundation
import Nimble
import FBSnapshotTestCase

public func manyImagesSnapshot(prefix: String) -> Predicate<Snapshotable> {

    return Predicate { (actual: Expression<Snapshotable>) throws -> PredicateResult in
        
        let testFileLocation = actual.location.file as NSString
        let type = ".\(testFileLocation.pathExtension)"
        let sanitizedName = testFileLocation.lastPathComponent.replacingOccurrences(of: type, with: "")
        let referenceImageDirectory = getDefaultReferenceDirectory(testFileLocation as String)
        let snapshotName = sanitizedTestName(prefix)
        
        let fileManager = FileManager.default

        let files = fileManager.subpaths(atPath: "\(referenceImageDirectory)/\(sanitizedName)")
        
        let elements = files?.filter({ (file) -> Bool in
            return file.hasPrefix("\(snapshotName)")
        })
        
        let instance = try! actual.evaluate()!
        let msg = ExpectationMessage.expectedActualValueTo("teste")
        
        for element in elements! {
            
            let pathName = element.characters.split(separator: "@").map(String.init).first!
            if FBSnapshotTest.compareSnapshot(instance, isDeviceAgnostic: false, usesDrawRect: false,
                                                  snapshot: "\(pathName)", record: false,
                                                  referenceDirectory: referenceImageDirectory, tolerance: 0,
                                                  filename: testFileLocation as String) {
                return PredicateResult(
                    status: .matches,
                    message: msg.appendedBeNilHint())
            }
        }
        
        return PredicateResult(
                status: .fail,
                message: msg.appendedBeNilHint())
    }
}
