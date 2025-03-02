import UIKit

public struct ButtonConfig {
    public let title: String?
    public let font: UIFont?
    public let textColor: UIColor?
    public let image: UIImage?

    public init(title: String?, font: UIFont?, textColor: UIColor?, image: UIImage?) {
        self.title = title
        self.font = font
        self.textColor = textColor
        self.image = image
    }
}
