//
//  RepositoriesViewModel.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

enum ViewType: Int {
    case day
    case week
    case month
}

protocol RepositoriesViewModel: AnyObject {
    var screenTitle: String { get }
    var dataSource: [String]? { get }
    
    func segmentedControlDidChange(viewType: ViewType)
}

class RepositoriesViewModelImpl: RepositoriesViewModel {
    var screenTitle: String {
        return NSLocalizedString("repositories_title", comment: "Repositories title")
    }
    
    var dataSource: [String]?
    
    func segmentedControlDidChange(viewType: ViewType) {

    }
}
