//  SimpleGenericTreeTests.swift
//  Copyright © 2015 Allen Holub. All rights reserved.
//

import XCTest
@testable import SwiftExercises

class SimpleGenericTreeTests: XCTestCase {

    var t: SimpleGenericTree<String>!
    
    override func setUp() {
        super.setUp()
        t = SimpleGenericTree<String>( ["d", "b", "f", "a", "c", "e", "g"] )
    }

    func testTreeStructure() {
        XCTAssertTrue( t._verifyChildren("d", left: "b", right: "f") )
        XCTAssertTrue( t._verifyChildren("b", left: "a", right: "c") )
        XCTAssertTrue( t._verifyChildren("f", left: "e", right: "g") )
        XCTAssertTrue( t._verifyChildren("a", left: nil, right: nil) )
        XCTAssertTrue( t._verifyChildren("c", left: nil, right: nil) )
        XCTAssertTrue( t._verifyChildren("e", left: nil, right: nil) )
        XCTAssertTrue( t._verifyChildren("g", left: nil, right: nil) )

        t.add("h")

        XCTAssertTrue( t._verifyChildren("d", left: "b", right: "f") )
        XCTAssertTrue( t._verifyChildren("b", left: "a", right: "c") )
        XCTAssertTrue( t._verifyChildren("f", left: "e", right: "g") )
        XCTAssertTrue( t._verifyChildren("a", left: nil, right: nil) )
        XCTAssertTrue( t._verifyChildren("c", left: nil, right: nil) )
        XCTAssertTrue( t._verifyChildren("e", left: nil, right: nil) )
        XCTAssertTrue( t._verifyChildren("g", left: nil, right: "h") )
        XCTAssertTrue( t._verifyChildren("h", left: nil, right: nil) )
    }

    func testArrayInit() {
        let t = Tree<String>( ["a", "b", "c"] )
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
        try! t.remove("c");
        try! t.remove("b");
        try! t.remove("e");
        try! t.remove("f");
        try! t.remove("d");

        XCTAssertTrue( t.count == 2 )
        XCTAssertTrue( t.contains("a") )
        XCTAssertTrue( t.contains("g") )

        do {
            try t.remove("xxxx")
            XCTFail()
        }
        catch TreeError.Empty {}
        catch { XCTFail() }

        do {
            t.clear()
            try t.remove("xxxx")
            XCTFail()
        }
        catch TreeError.Empty {}
        catch { XCTFail() }
    }

    func testTraversal() {
        var s = ""
        t.traverse(.Inorder){s += $0; return true}
        XCTAssertEqual(s, "abcdefg" )

        s = ""
        t.traverse(.Preorder){s += $0; return true}
        XCTAssertEqual(s, "dbacfeg")

        s = ""
        t.traverse(.Postorder){s += $0; return true}
        XCTAssertEqual(s, "acbegfd" )

        s = ""
        t.traverse{s += $0; return true}
        XCTAssertEqual(s, "abcdefg" )

        s = ""
        t.traverse {
            if( $0 <= "c") {
                s += $0
                return true // allow traversal to continue
            }
            return false // stop the traversal
        }
        XCTAssertEqual(s, "abc" )

        s = ""
        t.forEveryElement{ s += $0 }
        XCTAssertEqual(s, "abcdefg" )
    }

    func testAsString() {
        XCTAssertEqual(t.asString(","), "a,b,c,d,e,f,g" )
    }

    func testFilterMapReduce() {
        let result = t.filter{ $0 <= "d" }
                      .map   { return $0.uppercaseString }
                      .reduce("-"){ $0 + $1 }

        XCTAssertEqual(result, "-ABCD")
    }
}