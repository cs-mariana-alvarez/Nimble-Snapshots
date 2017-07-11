//
//  ManyImagesSnapshotTests.swift
//  Bootstrap
//
//  Created by Mariana Alvarez on 7/11/17.
//  Copyright © 2017 Artsy. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick

class ManyImagesSnapshotTests: QuickSpec {
    
    override func spec() {
        describe("in some context") {
            var view: UIView!
            
            beforeEach {
                setNimbleTolerance(0)
                setNimbleTestFolder("tests")
                view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = .blue
            }
            
            it("has valid snapshot") {
                expect(view).to(manyImagesSnapshot(prefix: "ManyImagesSnapshot"))
            }
        }
    }
}
