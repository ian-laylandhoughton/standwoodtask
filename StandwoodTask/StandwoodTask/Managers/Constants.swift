//
//  Constants.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

struct Constants {
    static let gitHubUrl = "https://api.github.com/search/repositories?q=created+%@&sort=stars&order=desc&page=%d"
    static let favouritesKey = "FavouriteRepos"
    static let standardDateFormat = "yyyy-MM-dd"
    static let formattedDateFormat = "dd/MM/yyyy"
    static let fullDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
}

struct DeviceType {
    static let isiPad = UIDevice.current.userInterfaceIdiom == .pad
}
