//
//  GetRepositoriesRequest.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

protocol GetRepositoriesRequest {
    func getRepositories(repoViewType: RepoViewType, pageNumber: Int, completion: @escaping ((repos: [GitHubRepo]?, totalRepos: Int)) -> Void, errorCallback: @escaping (Error?) -> Void)
}

class GetRepositoriesRequestImpl: GetRepositoriesRequest {
    
    func getRepositories(repoViewType: RepoViewType, pageNumber: Int, completion: @escaping ((repos: [GitHubRepo]?, totalRepos: Int)) -> Void, errorCallback: @escaping (Error?) -> Void) {
        guard let dateModifier = self.dateString(repoViewType: repoViewType) else {
            return
        }
            
        guard let gitUrl = URL(string: String(format: Constants.gitHubUrl, dateModifier, pageNumber)) else {
            return
        }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
            guard let data = data else {
                errorCallback(error)
                return
            }
            do {
                let gitData = try JSONDecoder().decode(GitHubRepoList.self, from: data)
                DispatchQueue.main.async {
                    completion((gitData.repos, gitData.totalRepos))
                }
            } catch {
                DispatchQueue.main.async {
                    errorCallback(STError(msg: "Failed to parse response"))
                }
            }
        }.resume()
    }
    
    private func dateString(repoViewType: RepoViewType) -> String? {
        switch repoViewType {
        case .day:
            return Date.yesterdayDateString()
        case .week:
            return Date.lastWeekDateString()
        case .month:
            return Date.lastMonthDateString()
        }
    }
}
