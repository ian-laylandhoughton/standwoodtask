//
//  FavouritesManager.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import Foundation

struct FavouritesManager {
    
    static func saveRepo(repo: GitHubRepo) {
        var savedRepos = self.getFavouriteRepos()
        savedRepos.append(repo)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedRepos) {
            UserDefaults.standard.set(encoded, forKey: Constants.favouritesKey)
        }
    }
    
    static func removeRepo(repo: GitHubRepo) {
        var savedRepos = self.getFavouriteRepos()
        for index in 0...savedRepos.count {
            if repo.repoName == savedRepos[index].repoName {
                savedRepos.remove(at: index)
                break
            }
        }
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(savedRepos) {
            UserDefaults.standard.set(encoded, forKey: Constants.favouritesKey)
        }
    }
    
    static func isFavourite(repo: GitHubRepo) -> Bool {
        let savedRepos = self.getFavouriteRepos()
        return savedRepos.contains(where: { $0.repoName == repo.repoName })
    }
    
    static private func getFavouriteRepos() -> [GitHubRepo] {
        if let favouriteRepos = UserDefaults.standard.value(forKey: Constants.favouritesKey) as? Data{
            if let repos = try? JSONDecoder().decode(Array.self, from: favouriteRepos) as [GitHubRepo] {
                return repos
            } else {
                return []
            }
        } else {
            return []
        }
    }
}
