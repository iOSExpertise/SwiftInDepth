//  StringTreeTests.swift
//  Copyright © 2015 Allen Holub. All rights reserved.
//

import XCTest
@testable import SwiftExercises

class StringTreeRemoveTests: XCTestCase {

    var t: StringTreeWithRemove! = nil
    
    override func setUp() {
        super.setUp()
        t = StringTreeWithRemove( ["d", "b", "f", "a", "c", "e", "g"] )
    }

    func testArrayInit() {
        let t = StringTreeWithRemove( ["a", "b", "c"] )
        XCTAssertTrue( t.contains("a") && t.contains("b") && t.contains("c") )
    }

    func testZeroAndOneElement() {
        t.clear()
        XCTAssertTrue( t.isEmpty    )
        XCTAssertNil ( t.smallest() )
        XCTAssertNil ( t.largest()  )

        t.add( "x" );

        XCTAssertTrue( t.count      ==  1  )
        XCTAssertTrue( t.smallest() == "x" )
        XCTAssertTrue( t.largest()  == "x" )
    }

    func testContains() {
        XCTAssertTrue ( t.contains("a") )
        XCTAssertTrue ( t.contains("b") )
        XCTAssertTrue ( t.contains("c") )
        XCTAssertTrue ( t.contains("d") )
        XCTAssertTrue ( t.contains("e") )
        XCTAssertTrue ( t.contains("f") )
        XCTAssertTrue ( t.contains("g") )
        XCTAssertFalse( t.contains("h") )
    }

    func testFindMatchOf() {
        XCTAssertTrue ( t.findMatchOf("a") == "a" )
        XCTAssertTrue ( t.findMatchOf("b") == "b" )
        XCTAssertTrue ( t.findMatchOf("c") == "c" )
        XCTAssertTrue ( t.findMatchOf("d") == "d" )
        XCTAssertTrue ( t.findMatchOf("e") == "e" )
        XCTAssertTrue ( t.findMatchOf("f") == "f" )
        XCTAssertTrue ( t.findMatchOf("g") == "g" )
        XCTAssertNil  ( t.findMatchOf("h") )
    }

    func testRemove() {
        t.remove("c");
        t.remove("b");
        t.remove("e");
        t.remove("f");
        t.remove("d");

        XCTAssertTrue( t.count == 2 )
        XCTAssertTrue( t.contains("a") )
        XCTAssertTrue( t.contains("g") )
    }
}
