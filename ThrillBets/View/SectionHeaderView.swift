//
//  SectionHeaderView.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/19/24.
//

import UIKit

/// UICollectionView subclass, used for displaying a single sport event
final class SectionHeaderView: UICollectionReusableView, ReusableView {

    // MARK: - Variables

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.headerLabelTextColor
        return label
    }()

    lazy var expandCollapseButton: UIButton = {
        let button = UIButton(type: .system)
        button.anchor(size: CGSize(width: 30, height: 30))
        button.tintColor = .chevronTintColor
        button.setImage(UIImage(named: SemanticImage.icCollapse.rawValue), for: .normal)
        button.addTarget(self, action: #selector(didTapExpandCollapseButton), for: .touchUpInside)
        return button
    }()
    
    /// Closure, executed after tapping on the expand/collapse button in the section header
    var didTapOnExpandCollapse: (() -> Void)?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.sectionHeaderColor
        addSubview(titleLabel)
        addSubview(expandCollapseButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            expandCollapseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            expandCollapseButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functionality
    
    /// Configuration of the section header view
    /// - Parameters:
    ///   - title: title of the header
    ///   - isCollapsed: current expand/collapse state of the section
    func configure(with title: String,
                   isCollapsed: Bool) {
        let image = SportImage(rawValue: title)
        let text: String
        if let image = image {
            text = "\(image.icon) \(title)"
        } else {
            text = title
        }
        titleLabel.text = text
        let icCollapse = UIImage(named: SemanticImage.icCollapse.rawValue)
        let icExpand = UIImage(named: SemanticImage.icExpand.rawValue)
        expandCollapseButton.setImage(isCollapsed ? icExpand : icCollapse, for: .normal)
    }

    @objc private func didTapExpandCollapseButton() {
        didTapOnExpandCollapse?()
    }
}

