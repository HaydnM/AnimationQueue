import Foundation


class AnimationQueue {
    
    private var items: [AnimationBatch]
    
    init() {
        self.items = []
    }
    
    /// Inserts the AnimationBatch into the queue
    func enqueue(_ animationBatchItem: AnimationBatch) {
        self.items.append(animationBatchItem)
    }
    
    /// Retrieves, but does not remove, the head of the queue, or returns nil if the queue is empty
    func head() -> AnimationBatch? {
        return self.items.first
    }
    
    /// Retrieves and removes the head of this queue, returns nil if the queue is empty
    func dequeue() -> AnimationBatch? {
        guard let _ = self.items.first else { return nil }
        return self.items.remove(at: 0)
    }
    
}
