import SwiftyToolz
import XCTest

final class SwiftyToolzTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsertionIndex() throws {
        XCTAssertEqual([Int]().insertionIndexAssumingIsSorted(for: 0), 0)
        XCTAssertEqual([Int]().insertionIndexAssumingIsSorted(for: 10), 0)
        XCTAssertEqual([0].insertionIndexAssumingIsSorted(for: -1), 0)
        XCTAssertEqual([0].insertionIndexAssumingIsSorted(for: 0), 1)
        XCTAssertEqual([0, 0].insertionIndexAssumingIsSorted(for: 0), 2)
        XCTAssertEqual([0, 1].insertionIndexAssumingIsSorted(for: 0), 1)
        XCTAssertEqual([0, 0, 1].insertionIndexAssumingIsSorted(for: 0), 2)
        XCTAssertEqual([0, 0, 1, 1].insertionIndexAssumingIsSorted(for: 0), 2)
        XCTAssertEqual([1].insertionIndexAssumingIsSorted(for: 0), 0)
        XCTAssertEqual([1].insertionIndexAssumingIsSorted(for: 1), 1)
        
        XCTAssertEqual([1, 1, 2, 2, 3, 3].insertionIndexAssumingIsSorted(for: 0), 0)
        XCTAssertEqual([1, 1, 2, 2, 3, 3].insertionIndexAssumingIsSorted(for: 1), 2)
        XCTAssertEqual([1, 1, 2, 2, 3, 3].insertionIndexAssumingIsSorted(for: 2), 4)
        XCTAssertEqual([1, 1, 2, 2, 3, 3].insertionIndexAssumingIsSorted(for: 3), 6)
        XCTAssertEqual([1, 1, 2, 2, 3, 3].insertionIndexAssumingIsSorted(for: 4), 6)
        
        XCTAssertEqual([1, 2, 3].insertionIndexAssumingIsSorted(for: 0), 0)
        XCTAssertEqual([1, 2, 3].insertionIndexAssumingIsSorted(for: 1), 1)
        XCTAssertEqual([1, 2, 3].insertionIndexAssumingIsSorted(for: 2), 2)
        XCTAssertEqual([1, 2, 3].insertionIndexAssumingIsSorted(for: 3), 3)
        XCTAssertEqual([1, 2, 3].insertionIndexAssumingIsSorted(for: 4), 3)
    }
}
