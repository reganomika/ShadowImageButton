import UIKit

public struct BackgroundImageConfig {
    public let image: UIImage?
    public let cornerRadius: CGFloat
    public let shadowConfig: ShadowConfig?

    public init(image: UIImage?, cornerRadius: CGFloat, shadowConfig: ShadowConfig? = nil) {
        self.image = image
        self.cornerRadius = cornerRadius
        self.shadowConfig = shadowConfig
    }
}
