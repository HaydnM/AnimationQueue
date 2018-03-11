import Foundation


class AnimationBatch: Equatable {
    
    let items: [AnimationBatchItem]
    
    init(items: [AnimationBatchItem]) {
        self.items = items
    }
    
    static func ==(lhs: AnimationBatch, rhs: AnimationBatch) -> Bool {
        return lhs === rhs
    }
    
    
}
