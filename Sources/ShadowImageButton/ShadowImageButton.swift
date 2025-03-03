import UIKit
import SnapKit

public final class ShadowImageButton: UIView {

    // MARK: - Properties

    public var action: (() -> Void)?

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()

    private var contentInsets: UIEdgeInsets = .zero

    // MARK: - Initialization

    public init(contentInsets: UIEdgeInsets = .zero) {
        self.contentInsets = contentInsets
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        addTarget()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        addSubview(backgroundImageView)
        addSubview(imageView)
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(contentInsets.left)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24) // Примерный размер иконки
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(8) // Отступ между иконкой и текстом
            make.right.equalToSuperview().inset(contentInsets.right)
            make.centerY.equalToSuperview()
        }
    }

    private func addTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        addGestureRecognizer(tapGesture)
    }

    // MARK: - Configuration

    public func configure(
        buttonConfig: ButtonConfig?,
        backgroundImageConfig: BackgroundImageConfig?
    ) {
        if let buttonConfig {
            if let title = buttonConfig.title {
                titleLabel.text = title
                titleLabel.textColor = buttonConfig.textColor
                titleLabel.font = buttonConfig.font
                titleLabel.isHidden = false
            } else {
                titleLabel.isHidden = true
            }

            if let image = buttonConfig.image {
                imageView.image = image
                imageView.isHidden = false
            } else {
                imageView.isHidden = true
            }
        } else {
            titleLabel.isHidden = true
            imageView.isHidden = true
        }

        if let backgroundImageConfig {
            updateBackgroundImageConfig(backgroundImageConfig)
        } else {
            backgroundImageView.isHidden = true
        }

        // Обновляем intrinsic content size
        invalidateIntrinsicContentSize()
    }

    public func updateTitle(title: String) {
        titleLabel.text = title
        invalidateIntrinsicContentSize()
    }

    public func updateBackgroundImageConfig(_ config: BackgroundImageConfig) {
        backgroundImageView.image = config.image
        backgroundImageView.layer.cornerRadius = config.cornerRadius
        backgroundImageView.isHidden = false

        layer.cornerRadius = config.cornerRadius

        if let shadowConfig = config.shadowConfig {
            layer.shadowColor = shadowConfig.color.cgColor
            layer.shadowOpacity = shadowConfig.opacity
            layer.shadowOffset = shadowConfig.offset
            layer.shadowRadius = shadowConfig.radius
            layer.masksToBounds = false
        } else {
            // Убираем тень, если shadowConfig отсутствует
            layer.shadowColor = nil
            layer.shadowOpacity = 0
            layer.shadowOffset = .zero
            layer.shadowRadius = 0
            layer.masksToBounds = true
        }
    }

    // MARK: - Intrinsic Content Size

    override public var intrinsicContentSize: CGSize {
        let imageWidth = imageView.isHidden ? 0 : imageView.frame.width
        let titleWidth = titleLabel.isHidden ? 0 : titleLabel.intrinsicContentSize.width
        let spacing = imageView.isHidden || titleLabel.isHidden ? 0 : 8 // Отступ между иконкой и текстом

        let totalWidth = imageWidth + titleWidth + CGFloat(spacing) + contentInsets.left + contentInsets.right
        let totalHeight = max(imageView.frame.height, titleLabel.intrinsicContentSize.height) + contentInsets.top + contentInsets.bottom

        return CGSize(width: totalWidth, height: totalHeight)
    }

    // MARK: - Actions

    @objc private func buttonTapped() {
        action?()
    }
}
