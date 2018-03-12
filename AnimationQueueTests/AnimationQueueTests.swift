import XCTest
@testable import AnimationQueue

class AnimationQueueTests: XCTestCase {
    
    var sut: AnimationQueue!
    var batch: AnimationBatch?
    var longBatch: AnimationBatch?
    
    override func setUp() {
        self.sut = AnimationQueue()
        
        let batchItem = AnimationBatchItem(animation: CAAnimation(), layer: CALayer(), key: "key")
        self.batch = AnimationBatch(items:[batchItem])
        
        let longAnimation = CAAnimation()
        longAnimation.duration = 100
        let longItem = AnimationBatchItem(animation: longAnimation, layer: CALayer(), key: "long")
        self.longBatch = AnimationBatch(items: [longItem])
    }
    
    override func tearDown() {
        self.sut = nil
        self.batch = nil
        self.longBatch = nil
    }
    
    func testThatAnimationQueue_DoesExist() {
        XCTAssertNotNil(sut, "should be able to create an AnimationQueue instance")
    }
    
    func testEmptyQueue_WhenEnqueuingAnimationBatch_AddsAnimationsImmediately() {
        sut.enqueue(batch!)

        XCTAssertNotNil(batch!.items.first?.layer.animation(forKey: "key"), "layer should have animation added")
    }
    
    func testEmptyQueue_AfterEnqueuingFirstBatchWithTwoAnimations_HasRunningAnimationCountOfTwo() {
        let animation1 = CAAnimation()
        animation1.duration = 100
        let animationItem1 = AnimationBatchItem(animation: animation1, layer: CALayer(), key: "animation1")
        let animation2 = CAAnimation()
        animation2.duration = 100
        let animationItem2 = AnimationBatchItem(animation: animation2, layer: CALayer(), key: "animation2")
        
        sut.enqueue(AnimationBatch(items: [animationItem1, animationItem2]))
        
        XCTAssertEqual(sut.animationCount, 2, "number of running animations should be two")
    }
    
    func testAnimationQueue_IsDelegateForEnqueuedAnimations() {
        sut.enqueue(batch!)
        
        let delegate = batch!.items.first?.layer.animation(forKey: "key")?.delegate as? AnimationQueue
        
        XCTAssertEqual(sut, delegate, "queue should be delegate for animation")
    }
    
    func testQueue_WithRunningAnimations_AddsNewBatchToQueue() {
        sut.enqueue(longBatch!)
        sut.enqueue(batch!)
        
        XCTAssertEqual(batch, sut.head(), "head of queue should be second batch enqueued")
    }
    
    func testQueueWithRunningAnimations_EnqueuingTwoBatches_HasTwoBatchesWaiting() {
        let batchItem2 = AnimationBatchItem(animation: CAAnimation(), layer: CALayer(), key: "key")
        let batch2 = AnimationBatch(items:[batchItem2])
        
        sut.enqueue(longBatch!)
        sut.enqueue(batch!)
        sut.enqueue(batch2)
        
        XCTAssertEqual(sut.batchCount, 2, "there should be two items waiting in queue")
    }
    
    func testQueue_AfterAnimationHasRun_HasAnimationCountOfZero() {
        sut.enqueue(longBatch!)
        sut.animationDidStop(longBatch!.items.first!.animation, finished: true)
        
        XCTAssertEqual(sut.animationCount, 0)
    }
    
    func testQueue_AfterAnimationHasRunWithBatchWaiting_HasBatchCountOfZero() {
        sut.enqueue(longBatch!)
        sut.enqueue(batch!)
        
        sut.animationDidStop(longBatch!.items.first!.animation, finished: true)
        
        XCTAssertEqual(sut.batchCount, 0)
    }
    
}
