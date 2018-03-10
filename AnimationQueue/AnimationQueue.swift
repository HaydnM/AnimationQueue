import Foundation


class AnimationQueue {
    
    private var itemQueue: [AnimationBatchItem]
    
    init() {
        self.itemQueue = []
    }
    
    /// Inserts the AnimationBatchItem into the queue
    func enqueue(_ animationBatchItem: AnimationBatchItem) {
        self.itemQueue.append(animationBatchItem)
    }
    
    /// Retrieves, but does not remove, the head of the queue, or returns nil if the queue is empty
    func head() -> AnimationBatchItem? {
        return self.itemQueue.first
    }
    
    /// Retrieves and removes the head of this queue, returns nil if the queue is empty
    func dequeue() -> AnimationBatchItem? {
        guard let _ = self.itemQueue.first else { return nil }
        return self.itemQueue.remove(at: 0)
    }
    
}
