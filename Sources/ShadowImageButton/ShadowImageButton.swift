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
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Initialization

    public init() {
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
        addSubview(stackView)
    }

    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
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
            stackView.isHidden = false

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
            stackView.isHidden = true
        }

        if let backgroundImageConfig {
            backgroundImageView.image = backgroundImageConfig.image
            backgroundImageView.layer.cornerRadius = backgroundImageConfig.cornerRadius
            backgroundImageView.isHidden = false

            layer.cornerRadius = backgroundImageConfig.cornerRadius

            if let shadowConfig = backgroundImageConfig.shadowConfig {
                layer.shadowColor = shadowConfig.color.cgColor
                layer.shadowOpacity = shadowConfig.opacity
                layer.shadowOffset = shadowConfig.offset
                layer.shadowRadius = shadowConfig.radius
                layer.masksToBounds = false
            }
        } else {
            backgroundImageView.isHidden = true
        }
    }

    public func updateTitle(title: String) {
        titleLabel.text = title
    }

    // MARK: - Actions

    @objc private func buttonTapped() {
        action?()
    }
}
