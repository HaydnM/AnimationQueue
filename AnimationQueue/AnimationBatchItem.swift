import Foundation


class AnimationBatchItem {
    let animation: CAAnimation
    let layer: CALayer
    let key: String
    
    init(animation: CAAnimation, layer: CALayer, key: String) {
        self.animation = animation
        self.layer = layer
        self.key = key
    }
}
