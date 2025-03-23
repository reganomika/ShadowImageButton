import UIKit

public struct ButtonConfig {
    public let title: String?
    public let font: UIFont?
    public let textColor: UIColor?
    public let image: UIImage?
    public let alignment: NSTextAlignment

    public init(title: String?, font: UIFont?, textColor: UIColor?, image: UIImage?, alignment: NSTextAlignment = .center) {
        self.title = title
        self.font = font
        self.textColor = textColor
        self.image = image
        self.alignment = alignment
    }
}
