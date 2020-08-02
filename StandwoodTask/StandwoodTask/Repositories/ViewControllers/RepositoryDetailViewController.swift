//
//  RepositoryDetailViewController.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 02/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {

    private var repo: GitHubRepo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = self.repo?.owner.username
    }

    func configure(repo: GitHubRepo) {
        self.repo = repo
    }

}
