//
//  RepositoryDetailViewModel.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 02/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

protocol RepositoryDetailViewModel: AnyObject {
    var screenTitle: String { get }
    var description: String { get }
    var langauge: String { get }
    var forks: String { get }
    var stars: String { get }
    var date: String { get }
    var githubUrl: URL? { get }
}

class RepositoryDetailViewModelImpl: RepositoryDetailViewModel {
    private var repo: GitHubRepo
    
    init(repo: GitHubRepo) {
        self.repo = repo
    }
    
    var description: String {
        return self.repo.description ?? ""
    }
    
    var screenTitle: String {
        return self.repo.owner.username
    }
    
    var langauge: String {
        return self.repo.language ?? ""
    }
    
    var forks: String {
        return String(self.repo.forks) + NSLocalizedString("forks", comment: "forks")
    }
        
    var stars: String {
        return String(self.repo.stars) + NSLocalizedString("stars", comment: "stars")
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.fullDateFormat
        
        guard let createdDate = dateFormatter.date(from: self.repo.creationDate) else {
            return ""
        }
        dateFormatter.dateFormat = Constants.formattedDateFormat
        
        return NSLocalizedString("created_on", comment: "created on") + dateFormatter.string(from: createdDate)
    }
    
    var githubUrl: URL? {
        return URL(string: self.repo.githubUrl)
    }
    
    
}
