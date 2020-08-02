//
//  GithubOwner.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

struct GithubOwner: Codable, Equatable {
    let username: String
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
    }
    
    static func == (lhs: GithubOwner, rhs: GithubOwner) -> Bool {
        return lhs.username == rhs.username &&
        lhs.avatarURL == rhs.avatarURL
    }
}
