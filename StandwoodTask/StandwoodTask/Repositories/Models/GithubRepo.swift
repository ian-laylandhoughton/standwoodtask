//
//  GithubRepo.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

struct GitHubRepo: Codable {
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
}
