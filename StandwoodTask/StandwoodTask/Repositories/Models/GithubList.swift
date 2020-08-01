//
//  GithubList.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import Foundation

struct GitHubRepoList: Codable {
    let repos: [GitHubRepo]?
    
    enum CodingKeys: String, CodingKey {
        case repos = "items"
    }
}
