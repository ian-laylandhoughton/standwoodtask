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

    static let DetailSegueIdentifier = "RepoListToRepoDetailSegue"
    private let repoCellIdentifier = "repoCell"
    private let repoCellNibName = "RepoCollectionViewCell"
    private let loadingCellIdentifier = "loadingCell"
    private let loadingCllNibName = "LoadingCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let repoCellNib = UINib(nibName: self.repoCellNibName, bundle: nil)
            self.collectionView.register(repoCellNib, forCellWithReuseIdentifier: self.repoCellIdentifier)
            
            let loadingCellNib = UINib(nibName: self.loadingCllNibName, bundle: nil)
            self.collectionView.register(loadingCellNib, forCellWithReuseIdentifier: self.loadingCellIdentifier)
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: RepositoriesViewModel = RepositoriesViewModelImpl()
    private var selectedRepo: GitHubRepo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.delegate = self
        self.segmentedControlDidChange(sender: self.segmentedControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = self.viewModel.screenTitle
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == RepositoriesViewController.DetailSegueIdentifier {
            guard let detailVC = segue.destination as? RepositoryDetailViewController, let repo = self.selectedRepo else {
                return
            }
            let viewModel = RepositoryDetailViewModelImpl(repo: repo)
            detailVC.configure(viewModel: viewModel)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: NSLocalizedString("back", comment: "Back"), style: .plain, target: nil, action: nil)
        }
    }
    
    @IBAction private func segmentedControlDidChange(sender: UISegmentedControl) {
        self.viewModel.segmentedControlDidChange(viewType: RepoViewType(rawValue: sender.selectedSegmentIndex) ?? .day)
        
        UIView.animate(withDuration: TimeInterval.normal, animations: {
            self.collectionView.alpha = CGFloat.Alpha.clear
        }) { _ in
            self.collectionView.reloadData() 
            self.collectionView.setContentOffset(.zero, animated: false)
        }
    }
}

extension RepositoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.willDiplayCell(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.hasMoreRepos ? self.viewModel.dataSource.count + 1 : self.viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == self.viewModel.dataSource.count) && self.viewModel.hasMoreRepos {
            return collectionView.dequeueReusableCell(withReuseIdentifier: self.loadingCellIdentifier, for: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.repoCellIdentifier, for: indexPath) as! RepoCollectionViewCell
            cell.configure(repo: self.viewModel.dataSource[indexPath.row], delegate: self)
            
            return cell as! UICollectionViewCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRepo = self.viewModel.dataSource[indexPath.row]
        self.performSegue(withIdentifier: RepositoriesViewController.DetailSegueIdentifier, sender: nil)
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
