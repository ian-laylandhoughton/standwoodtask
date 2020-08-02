//
//  RepositoryDetailViewController.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 02/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var viewModel: RepositoryDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = self.viewModel?.screenTitle
        self.descriptionLabel.text = self.viewModel?.description
        self.languageLabel.text = self.viewModel?.langauge
        self.forksLabel.text = self.viewModel?.forks
        self.starsLabel.text = self.viewModel?.stars
        self.dateLabel.text = self.viewModel?.date
    }

    func configure(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
    }
    
    @IBAction func openGithubButtonPressed() {
        if let url = self.viewModel?.githubUrl {
            UIApplication.shared.open(url)
        }
    }

}
