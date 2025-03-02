import UIKit

public struct ShadowConfig {
    public let color: UIColor
    public let opacity: Float
    public let offset: CGSize
    public let radius: CGFloat

    public init(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        self.color = color
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
    }
}
