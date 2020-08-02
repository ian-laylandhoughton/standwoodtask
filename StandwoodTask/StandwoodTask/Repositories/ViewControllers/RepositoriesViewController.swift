//
//  FirstViewController.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit
import StanwoodCore

class RepositoriesViewController: UIViewController {

    private let cellIdentifier = "repoCell"
    private let cellNibName = "RepoCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let repoCellNib = UINib(nibName: self.cellNibName, bundle: nil)
            self.collectionView.register(repoCellNib, forCellWithReuseIdentifier: self.cellIdentifier)
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: RepositoriesViewModel = RepositoriesViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModel.screenTitle
        self.viewModel.delegate = self
        self.segmentedControlDidChange(sender: self.segmentedControl)
    }
    
    @IBAction private func segmentedControlDidChange(sender: UISegmentedControl) {
        self.viewModel.segmentedControlDidChange(viewType: RepoViewType(rawValue: sender.selectedSegmentIndex) ?? .day)
        
        UIView.animate(withDuration: TimeInterval.normal) {
            self.collectionView.alpha = CGFloat.Alpha.clear
        }
    }
}

extension RepositoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! RepoCollectionViewCell
        cell.configure(repo: self.viewModel.dataSource[indexPath.row], delegate: self)
        return cell as! UICollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.cellSize
    }
}

extension RepositoriesViewController: RepositoriesViewModelDelegate {
    
    func getReposOnComplete() {
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
        
        UIView.animate(withDuration: TimeInterval.normal) {
            self.collectionView.alpha = CGFloat.Alpha.full
        }
    }
    
    func getReposDidFail(error: String) {
        let alertController = UIAlertController(title: NSLocalizedString("generic_error_title", comment: "Error title"), message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("retry", comment: "Retry"), style: .default, handler: { _ in
            
        }))
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Cancel"), style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RepositoriesViewController: RepoCollectionViewCellDelegate {
    func didToggleFavouriteOnRepo(repo: GitHubRepo) {
        FavouritesManager.isFavourite(repo: repo) ? FavouritesManager.removeRepo(repo: repo) : FavouritesManager.saveRepo(repo: repo)
        guard let index = self.viewModel.dataSource.firstIndex(of: repo) else {
            return
        }
        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
}
