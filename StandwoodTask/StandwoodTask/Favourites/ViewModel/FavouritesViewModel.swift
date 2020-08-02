//
//  FavouritesViewModel.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 02/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

class FavouritesViewModelImpl: ReposViewModel {
    let cellHeight: CGFloat = 90
    let cellPadding: CGFloat = 20
    
    var screenTitle: String {
        return NSLocalizedString("favourites", comment: "Favourites")
    }
    
    var cellSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - self.cellPadding, height: self.cellHeight)
    }
    
    var dataSource: [GitHubRepo] {
        return FavouritesManager.allRepos()
    }
    
    var delegate: RepositoriesViewModelDelegate?
    var hasMoreRepos: Bool = false
    
    func refresh() {
        // intentionally left blank
    }
    
    func segmentedControlDidChange(viewType: RepoViewType) {
        // intentionally left blank
    }
    
    func willDiplayCell(indexPath: IndexPath) {
        // intentionally left blank
    }
}
