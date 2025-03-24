import UIKit

public struct ButtonConfig {
    public let title: String?
    public let font: UIFont?
    public let textColor: UIColor?
    public let image: UIImage?
    public let alignment: NSTextAlignment
    public let imageSize: CGSize
    public let imageInset: CGFloat

    public init(
        title: String?,
        font: UIFont?,
        textColor: UIColor?,
        image: UIImage?,
        alignment: NSTextAlignment = .center,
        imageSize: CGSize = .init(width: 24, height: 24),
        imageInset: CGFloat = 10
    ) {
        self.title = title
        self.font = font
        self.textColor = textColor
        self.image = image
        self.alignment = alignment
        self.imageSize = imageSize
        self.imageInset = imageInset
    }
}
