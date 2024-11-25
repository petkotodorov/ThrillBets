//
//  ItemCollectionViewCell.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/19/24.
//

import UIKit

/// UICollectionView subclass, used for displaying a single sport event
final class ItemCollectionViewCell: UICollectionViewCell, ReusableView {

    // MARK: - Variables

    private let firstCompetitor: UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.commonTextColor
        return label
    }()

    private let secondCompetitor: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.commonTextColor
        return label
    }()

    private lazy var competitorsVStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [firstCompetitor, secondCompetitor])
        vStack.axis = .vertical
        vStack.spacing = 5
        return vStack
    }()

    private let timerView: TimerView = {
        return TimerView()
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.anchor(size: CGSize(width: 30, height: 30))
        button.setImage(UIImage(named: SemanticImage.icStarUnfilled.rawValue), for: .normal)
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        return button
    }()
    
    /// Closure, executed after tapping on favorite button
    var didTapOnFavorite: (() -> Void)?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear

        let containerView = UIView()
        containerView.addSubviews(timerView,
                                  favoriteButton,
                                  competitorsVStack)

        timerView.anchor(top: containerView.topAnchor,
                         padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        timerView.centerXToSuperview()

        favoriteButton.anchor(top: timerView.bottomAnchor,
                              padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        favoriteButton.centerXToSuperview()

        competitorsVStack.anchor(top: favoriteButton.bottomAnchor,
                                 leading: containerView.leadingAnchor,
                                 trailing: containerView.trailingAnchor,
                                 padding: UIEdgeInsets(top: 5, left: 3, bottom: 0, right: 3))
        competitorsVStack.centerXToSuperview()

        contentView.addSubview(containerView)
        containerView.fillSuperview(padding: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        timerView.resetTimer()
    }

    // MARK: - Functionality
    
    /// Configuration of the cell's content
    /// - Parameter eventItem: data transfer object, with all needed data for the particular event
    func configure(with eventItem: EventSectionItem) {
        let event = eventItem.event
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTime))
        timerView.configureTime(eventDate: date)

        let icStarFilled = UIImage(named: SemanticImage.icStarFilled.rawValue)
        let icStarUnfilled = UIImage(named: SemanticImage.icStarUnfilled.rawValue)
        favoriteButton.setImage(eventItem.isFavorite ? icStarFilled : icStarUnfilled, for: .normal)

        let competitors = event.name.components(separatedBy: "-")
        guard competitors.count == 2 else {
            // doesn't make sense
            return
        }
        firstCompetitor.text = competitors.first
        secondCompetitor.text = competitors.last
    }

    @objc private func didTapFavorite() {
        didTapOnFavorite?()
    }
}
