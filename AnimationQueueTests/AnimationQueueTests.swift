import XCTest
@testable import AnimationQueue

class AnimationQueueTests: XCTestCase {
    
    var sut: AnimationQueue!
    var batch: AnimationBatch?
    
    override func setUp() {
        self.sut = AnimationQueue()
        
        let batchItem = AnimationBatchItem(animation: CAAnimation(), layer: CALayer(), key: "key")
        self.batch = AnimationBatch(items:[batchItem])
    }
    
    override func tearDown() {
        self.sut = nil
        self.batch = nil
    }
    
    func testThatAnimationQueue_DoesExist() {
        XCTAssertNotNil(sut, "should be able to create an AnimationQueue instance")
    }
    
    func testThatAnimationQueue_CanEnqueueItem() {
        sut.enqueue(batch!)
        
        XCTAssertEqual(batch, sut.head(), "the AnimationBatchItem enqueued does not match the one returned from queue")
    }
    
    func testAnimationQueue_WhenDequeuing_ReturnsFirstQueuedItem() {
        let batch2 = AnimationBatch(items: [AnimationBatchItem(animation: CAAnimation(), layer: CALayer(), key: "key")])
        
        sut.enqueue(batch!)
        sut.enqueue(batch2)
        
        XCTAssertEqual(batch, sut.dequeue(), "the first AnimationBatchItem enqueued does not match the one that was dequeued")
    }
    
    func testAnimationQueueWithOneItem_AfterDequeuing_IsEmpty() {
        sut.enqueue(batch!)
        _ = sut.dequeue()
        
        XCTAssertNil(sut.dequeue(), "expected queue to be empty")
    }
    
}
