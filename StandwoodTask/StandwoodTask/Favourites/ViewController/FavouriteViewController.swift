//
//  SecondViewController.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

class FavouriteViewController: RepositoriesViewController {
    
    override func viewDidLoad() {
        self.viewModel = FavouritesViewModelImpl()
        self.collectionView.refreshControl = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }

    override func didToggleFavouriteOnRepo(repo: GitHubRepo) {
        guard let index = self.viewModel.dataSource.firstIndex(of: repo) else {
            return
        }
        
        FavouritesManager.removeRepo(repo: repo)
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
        })
    }
}
