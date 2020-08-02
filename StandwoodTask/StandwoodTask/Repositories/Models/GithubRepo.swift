//
//  GithubRepo.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

struct GitHubRepo: Codable, Equatable {
    let owner: GithubOwner
    let repoName: String
    let description: String?
    let stars: Int
    let language: String?
    let forks: Int
    let creationDate: String
    let githubUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case owner
        case repoName = "name"
        case description
        case stars = "stargazers_count"
        case language
        case forks
        case creationDate = "created_at"
        case githubUrl = "html_url"
    }
    
    static func == (lhs: GitHubRepo, rhs: GitHubRepo) -> Bool {
        return lhs.owner == rhs.owner &&
        lhs.repoName == rhs.repoName &&
        lhs.description == rhs.description &&
        lhs.stars == rhs.stars &&
        lhs.language == rhs.language &&
        lhs.forks == rhs.forks &&
        lhs.creationDate == rhs.creationDate &&
        lhs.githubUrl == rhs.githubUrl
    }
}
