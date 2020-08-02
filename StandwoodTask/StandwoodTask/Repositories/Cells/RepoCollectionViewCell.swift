//
//  RepoCollectionViewCell.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

protocol RepoCollectionViewCellDelegate {
    func didToggleFavouriteOnRepo(repo: GitHubRepo)
}

protocol RepoCollectionViewCell {
    func configure(repo: GitHubRepo, delegate: RepoCollectionViewCellDelegate)
}

class RepoCollectionViewCellImpl: UICollectionViewCell, RepoCollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var delegate: RepoCollectionViewCellDelegate?
    private var repo: GitHubRepo?
    
    func configure(repo: GitHubRepo, delegate: RepoCollectionViewCellDelegate) {
        self.avatarImageView.load(url: repo.owner.avatarURL)
        self.favouriteButton.isSelected = FavouritesManager.isFavourite(repo: repo)
        self.titleLabel.text = "\(repo.owner.username)/\(repo.repoName)"
        self.descriptionLabel.text = repo.description
        
        self.repo = repo
        self.delegate = delegate
    }
    
    @IBAction func favouritesButtonPressed() {
        guard let unwrappedRepo = self.repo else {
            return
        }
        self.delegate?.didToggleFavouriteOnRepo(repo: unwrappedRepo)
    }
}

