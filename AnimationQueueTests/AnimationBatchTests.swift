import XCTest
@testable import AnimationQueue

class AnimationBatchTests: XCTestCase {
    
    func testThatNewAnimationBatch_WhenInitialisedWithOneItem_ContainsOneItem() {
        let item = AnimationBatchItem(animation: CAAnimation(), layer: CALayer(), key: "key")
        let sut = AnimationBatch(items: [item])
        
        XCTAssertTrue(sut.items.count == 1, "animation batch should contain 1 item")
    }
    
    
}
