//
//  FirstViewController.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    private let viewModel: RepositoriesViewModel = RepositoriesViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModel.screenTitle
    }
}

