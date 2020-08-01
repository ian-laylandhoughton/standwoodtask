//
//  RepoCollectionViewCell.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

protocol RepoCollectionViewCell {
    func configure(repo: GitHubRepo)
}

class RepoCollectionViewCellImpl: UICollectionViewCell, RepoCollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(repo: GitHubRepo) {
        self.avatarImageView.load(url: repo.owner.avatarURL)
        self.favouriteButton.isSelected = FavouritesManager.isFavourite(repo: repo)
        self.titleLabel.text = "\(repo.owner.username)/\(repo.repoName)"
        self.descriptionLabel.text = repo.description
    }
}

