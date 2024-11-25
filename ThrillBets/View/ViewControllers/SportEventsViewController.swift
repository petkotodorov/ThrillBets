//
//  SportEventsViewController.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/20/24.
//

import UIKit

/// View Controller, representing the entry point of the app. Showing a list of Sports and their upcoming events
class SportEventsViewController: BaseViewController {

    // MARK: - Variables

    private let sportsViewModel: SportsViewModel

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .collectionBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HorizontalCollectionViewCell.self,
                                forCellWithReuseIdentifier: HorizontalCollectionViewCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        return collectionView
    }()

    // MARK: - Initializers
    
    /// Designated initializer of SportEventsViewController
    /// - Parameter sportsViewModel: viewModel, used for fetching date and preparing it for the UI
    init(sportsViewModel: SportsViewModel) {
        self.sportsViewModel = sportsViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        loadContent()
    }

    // MARK: - Functionality
    
    private func setupUi() {
        title = "Thrill bets"
        view.backgroundColor = .collectionBackgroundColor
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }

    private func loadContent() {
        startLoader(start: true)
        Task {
            do {
                try await sportsViewModel.load()
                startLoader(start: false)
                collectionView.reloadData()
            } catch {
                display(alert: "Something went wrong", 
                        message: error.localizedDescription)
                startLoader(start: false)
            }
        }
    }

}

// MARK: - Extensions

extension SportEventsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sportsViewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        let sportSection = sportsViewModel.sportSection(at: section)
        return sportSection.isCollapsed ? 0 : 1
    }

    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.reuseIdentifier, for: indexPath) as? HorizontalCollectionViewCell else {
            return UICollectionViewCell()
        }
        let sportSection = sportsViewModel.sportSection(at: indexPath.section)
        cell.configure(with: sportSection.eventSectionVM)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, 
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        let sportSection = sportsViewModel.sportSection(at: indexPath.section)
        headerView.configure(with: sportSection.sport.name,
                             isCollapsed: sportSection.isCollapsed)
        headerView.didTapOnExpandCollapse = { [weak self] in
            guard let sSelf = self else { return }
            sSelf.sportsViewModel.sportSection(at: indexPath.section).isCollapsed.toggle()
            sSelf.collectionView.reloadSections(IndexSet(integer: indexPath.section))
        }
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}
