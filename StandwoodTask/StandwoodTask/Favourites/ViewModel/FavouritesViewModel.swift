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
    let cellPadding: CGFloat = 10
    
    var screenTitle: String {
        return NSLocalizedString("favourites", comment: "Favourites")
    }
    
    private var iPhoneCellSize: CGSize {
        return CGSize(width: self.delegate?.collectionViewSize().width ?? 0 - (self.cellPadding * 2), height: self.cellHeight)
    }
    
    private var iPadCellSize: CGSize {
        guard let unwrapepdCollectionViewSize = self.delegate?.collectionViewSize() else {
            return .zero
        }
        return CGSize(width: unwrapepdCollectionViewSize.width / 3 - self.cellPadding, height: unwrapepdCollectionViewSize.height / 2 - self.cellPadding)
    }
    
    var cellSize: CGSize {
        return UIDevice.current.userInterfaceIdiom == .pad ? self.iPadCellSize : self.iPadCellSize
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
