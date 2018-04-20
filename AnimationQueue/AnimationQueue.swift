import UIKit


class AnimationQueue: NSObject, CAAnimationDelegate {
    
    private var batches: [AnimationBatch]
    private(set) var animationCount: Int
    private var paused: Bool
    
    // MARK: - Initialiser
    
    override init() {
        self.batches = []
        self.animationCount = 0
        self.paused = false
        
        super.init()
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Queue
    
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
            batchItem.animation.beginTime = batchItem.layer.convertTime(CACurrentMediaTime(), from: nil) + batchItem.offset
            batchItem.layer.add(batchItem.animation.copy() as! CAAnimation, forKey: batchItem.key)
        }
    }
    
    // MARK: - Animation Delegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.animationCount > 0 { self.animationCount -= 1 }
        if paused == true { return }
        
        if let _ = self.head(), self.animationCount == 0 {
            self.runBatch(self.batches.removeFirst())
        }
    }
    
    // MARK: - Notification Handlers
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationEnteringBackground), name: .UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationReturnedForeground), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc func applicationEnteringBackground() {
        self.paused = true
    }
    
    @objc func applicationReturnedForeground() {
        self.paused = false
        
        if let _ = self.head(), self.animationCount == 0 {
            self.runBatch(self.batches.removeFirst())
        }
    }
}
