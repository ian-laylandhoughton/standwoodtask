//
//  GithubOwner.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

struct GithubOwner: Codable {
    let username: String
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
    }
}
