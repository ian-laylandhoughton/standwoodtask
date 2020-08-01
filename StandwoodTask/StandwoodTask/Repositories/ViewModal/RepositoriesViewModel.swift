//
//  RepositoriesViewModel.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

protocol RepositoriesViewModel: AnyObject {
    var screenTitle: String { get }
}

class RepositoriesViewModelImpl: RepositoriesViewModel {
    var screenTitle: String {
        return NSLocalizedString("repositories_title", comment: "Repositories title")
    }
}
