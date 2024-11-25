//
//  HorizontalCollectionViewCell.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/19/24.
//

import UIKit

/// View, used for displaying a section header
final class HorizontalCollectionViewCell: UICollectionViewCell, ReusableView {

    // MARK: - Variables

    private var viewModel: EventSectionViewModel?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        collectionView.backgroundColor = .clear

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: ItemCollectionViewCell.reuseIdentifier)

        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functionality
    
    /// Configuration of the view model, for the particular cell
    /// - Parameter viewModel: view model, responsible for the particular event
    func configure(with viewModel: EventSectionViewModel) {
        self.viewModel = viewModel
        self.viewModel?.updateIndexes = { [weak self] sourceIndex, destinationIndex in
            let sourceIndexPath = IndexPath(item: sourceIndex, section: 0)
            let destinationIndexPath = IndexPath(item: destinationIndex, section: 0)
            self?.collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            self?.collectionView.reloadItems(at: [sourceIndexPath, destinationIndexPath])
        }
        collectionView.reloadData()
    }
}

// MARK: - Extensions

extension HorizontalCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as? ItemCollectionViewCell,
              let vm = viewModel else {
            return UICollectionViewCell()
        }
        cell.didTapOnFavorite = { [weak self] in
            guard let vm = self?.viewModel else { return }
            vm.markFavorite(at: indexPath.item)
        }
        cell.configure(with: vm.item(at: indexPath.row))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: collectionView.frame.height)
    }
}

