//
//  RepositoriesViewModel.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

enum RepoViewType: Int {
    case day
    case week
    case month
}

protocol RepositoriesViewModelDelegate {
    func getReposOnComplete()
    func getReposDidFail(error: String)
    func collectionViewSize() -> CGSize
}

protocol ReposViewModel {
    var cellHeight: CGFloat { get }
    var cellPadding: CGFloat { get }
    var screenTitle: String { get }
    var cellSize: CGSize { get }
    var dataSource: [GitHubRepo] { get }
    var delegate: RepositoriesViewModelDelegate? { get set }
    var hasMoreRepos: Bool { get }
    func segmentedControlDidChange(viewType: RepoViewType?)
    func willDiplayCell(indexPath: IndexPath)
    func refresh()
}

extension ReposViewModel {
    func segmentedControlDidChange(viewType: RepoViewType? = nil) { }
}

class RepositoriesViewModelImpl: ReposViewModel {
    let cellHeight: CGFloat = 90
    let cellPadding: CGFloat = 10
    
    private var iPhoneCellSize: CGSize {
        return CGSize(width: self.delegate?.collectionViewSize().width ?? 0 - (self.cellPadding * 2), height: self.cellHeight)
    }
    
    private var iPadCellSize: CGSize {
        guard let unwrapepdCollectionViewSize = self.delegate?.collectionViewSize() else {
            return .zero
        }
        return CGSize(width: unwrapepdCollectionViewSize.width / 3 - self.cellPadding, height: unwrapepdCollectionViewSize.height / 2 - self.cellPadding)
    }
    
    var screenTitle: String {
        return NSLocalizedString("repositories_title", comment: "Repositories title")
    }
    
    var cellSize: CGSize {
        return DeviceType.isiPad ? self.iPadCellSize : self.iPhoneCellSize
    }
    
    var hasMoreRepos: Bool {
        return self.dataSource.count != self.totalNumberOfRepos
    }
    
    var delegate: RepositoriesViewModelDelegate?
    var dataSource: [GitHubRepo] = []
    
    private var currentRepoViewType: RepoViewType = .day
    private var pageNumber: Int = 1
    private var totalNumberOfRepos: Int = 0
    
    private func performRequest() {
        let request = GetRepositoriesRequestImpl()
        request.getRepositories(repoViewType: self.currentRepoViewType, pageNumber: self.pageNumber, completion: { result in
            
            guard let unwrappedRepos = result.repos else {
                self.delegate?.getReposOnComplete()
                return
            }
            self.totalNumberOfRepos = result.totalRepos
            self.dataSource.append(contentsOf: unwrappedRepos)
                        
            DispatchQueue.main.async {
                self.delegate?.getReposOnComplete()
            }
            
        }) { error in
            DispatchQueue.main.async {
                self.delegate?.getReposDidFail(error: error?.localizedDescription ?? NSLocalizedString("generic_error_description", comment: "error description"))
            }
        }
    }
    
    func refresh() {
        self.segmentedControlDidChange()
    }
    
    func segmentedControlDidChange(viewType: RepoViewType? = nil) {
        guard let type = viewType == nil ? self.currentRepoViewType : viewType else {
            return
        }
        self.dataSource.removeAll()
        self.totalNumberOfRepos = 0
        self.currentRepoViewType = type
        self.pageNumber = 1
        self.performRequest()
    }
    
    func willDiplayCell(indexPath: IndexPath) {
        if indexPath.row == (self.dataSource.count - 2) && self.hasMoreRepos {
            self.pageNumber += 1
            self.performRequest()
        }
    }
}
