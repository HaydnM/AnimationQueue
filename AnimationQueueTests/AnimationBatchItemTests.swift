import XCTest
@testable import AnimationQueue

class AnimationBatchItemTests: XCTestCase {
    
    var sut: AnimationBatchItem!
    var animation: CAAnimation!
    var layer: CALayer!
    var key: String!

    override func setUp() {
        self.animation = CAAnimation()
        self.layer = CALayer()
        self.key = "key"
        
        self.sut = AnimationBatchItem(animation: animation, layer: layer, key: key)
    }

    override func tearDown() {
        self.animation = nil
        self.layer = nil
        self.key = nil

        self.sut = nil
    }
    
    func testThatAnimationBatchItem_DoesExist() {
        XCTAssertNotNil(sut, "should be able to create an AnimationBatchItem instance")
    }
    
    func testThatNewAnimationBatchItem_MustHaveAnimation() {
        XCTAssertEqual(animation, sut.animation, "the animation should be the one passed to it at initialisation")
    }
    
    func testThatNewAnimationBatchItem_MustHaveLayer() {
        XCTAssertEqual(layer, sut.layer, "the layer should be the one passed to it at initialisation")
    }
    
    func testThatNewAnimationBatchItem_MustHaveAnimationKey() {
        XCTAssertEqual(key, sut.key, "the animaiton key should be the one passed to it at initialisation")
    }
    
    
}
