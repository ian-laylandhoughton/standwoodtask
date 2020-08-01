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
}

protocol RepositoriesViewModel: AnyObject {
    var screenTitle: String { get }
    var cellSize: CGSize { get }
    var dataSource: [GitHubRepo] { get }
    var delegate: RepositoriesViewModelDelegate? { get set }
    func segmentedControlDidChange(viewType: RepoViewType)
}

class RepositoriesViewModelImpl: RepositoriesViewModel {
    private let cellHeight: CGFloat = 90
    private let cellPadding: CGFloat = 100
    
    var screenTitle: String {
        return NSLocalizedString("repositories_title", comment: "Repositories title")
    }
    
    var cellSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - self.cellPadding, height: self.cellHeight)
    }
    
    var dataSource: [GitHubRepo] = []
    var delegate: RepositoriesViewModelDelegate?
    private var currentRepoViewType: RepoViewType = .day
    private var pageNumber: Int = 1
    
    private func performRequest() {
        let request = GetRepositoriesRequestImpl()
        request.getRepositories(repoViewType: self.currentRepoViewType, pageNumber: self.pageNumber, completion: { repos in
            guard let unwrappedRepos = repos else {
                self.delegate?.getReposOnComplete()
                return
            }
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
    
    func segmentedControlDidChange(viewType: RepoViewType) {
        self.dataSource.removeAll()
        self.currentRepoViewType = viewType
        self.pageNumber = 1
        self.performRequest()
    }
}
