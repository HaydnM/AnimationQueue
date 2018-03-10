import XCTest
@testable import AnimationQueue

class AnimationQueueTests: XCTestCase {
    
    var sut: AnimationQueue!
    var batchItem: AnimationBatchItem!
    
    override func setUp() {
        self.sut = AnimationQueue()
        self.batchItem = AnimationBatchItem(animation: CAAnimation(), layer: CALayer(), key: "key")
    }
    
    override func tearDown() {
        self.sut = nil
        self.batchItem = nil
    }
    
    func testThatAnimationQueue_DoesExist() {
        XCTAssertNotNil(sut, "should be able to create an AnimationQueue instance")
    }
    
    func testThatAnimationQueue_CanEnqueueItem() {
        sut.enqueue(batchItem)
        
        XCTAssertEqual(batchItem, sut.head(), "the AnimationBatchItem enqueued does not match the one returned from queue")
    }
    
    func testAnimationQueue_WhenDequeuing_ReturnsFirstQueuedItem() {
        let batchItem2 = AnimationBatchItem(animation: CAAnimation(), layer: CALayer(), key: "key2")
        
        sut.enqueue(batchItem)
        sut.enqueue(batchItem2)
        
        XCTAssertEqual(batchItem, sut.dequeue(), "the first AnimationBatchItem enqueued does not match the one that was dequeued")
    }
    
    func testAnimationQueueWithOneItem_AfterDequeuing_IsEmpty() {
        sut.enqueue(batchItem)
        _ = sut.dequeue()
        
        XCTAssertNil(sut.dequeue(), "expected queue to be empty")
    }
    
}
