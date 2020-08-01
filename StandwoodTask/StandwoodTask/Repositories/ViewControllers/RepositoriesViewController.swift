//
//  FirstViewController.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private let viewModel: RepositoriesViewModel = RepositoriesViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModel.screenTitle
        self.viewModel.delegate = self
        self.segmentedControlDidChange(sender: self.segmentedControl)
    }
    
    @IBAction private func segmentedControlDidChange(sender: UISegmentedControl) {
        self.viewModel.segmentedControlDidChange(viewType: RepoViewType(rawValue: sender.selectedSegmentIndex) ?? .day)
        self.collectionView.reloadData()
    }
}

extension RepositoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension RepositoriesViewController: RepositoriesViewModelDelegate {
    func getReposOnComplete() {
        self.collectionView.reloadData()
    }
    
    func getReposDidFail(error: String) {
        let alertController = UIAlertController(title: NSLocalizedString("generic_error_title", comment: "Error title"), message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("retry", comment: "Retry"), style: .default, handler: { _ in
            
        }))
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "Cancel"), style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
