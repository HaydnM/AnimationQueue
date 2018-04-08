import Foundation


class AnimationQueue: NSObject, CAAnimationDelegate {
    
    private var batches: [AnimationBatch]
    private(set) var animationCount: Int
    
    override init() {
        self.animationCount = 0
        self.batches = []
        
        super.init()
    }
    
    var batchCount: Int {
        return self.batches.count
    }
    
    func enqueue(_ animationBatch: AnimationBatch) {
        if animationCount > 0 {
            self.batches.append(animationBatch)
        } else {
            self.runBatch(animationBatch)
        }
    }
    
    func head() -> AnimationBatch? {
        return batches.first
    }
    
    private func runBatch(_ batch: AnimationBatch) {
        
        for batchItem in batch.items {
            animationCount += 1
            batchItem.animation.delegate = self
            batchItem.animation.beginTime = batchItem.layer.convertTime(CACurrentMediaTime(), from: nil) + batchItem.animation.timeOffset
            batchItem.layer.add(batchItem.animation, forKey: batchItem.key)
        }
    }
    
    // MARK: - Animation Delegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.animationCount > 0 { self.animationCount -= 1 }
        
        if let _ = self.head(), self.animationCount == 0 {
            self.runBatch(self.batches.removeFirst())
        }
    }
}
