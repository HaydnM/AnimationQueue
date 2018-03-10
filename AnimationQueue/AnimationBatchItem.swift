import Foundation


class AnimationBatchItem: Equatable {
    let animation: CAAnimation
    let layer: CALayer
    let key: String
    
    init(animation: CAAnimation, layer: CALayer, key: String) {
        self.animation = animation
        self.layer = layer
        self.key = key
    }
    
    static func ==(lhs: AnimationBatchItem, rhs: AnimationBatchItem) -> Bool {
        return lhs === rhs
    }
}
